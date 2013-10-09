# == Schema Information
#
# Table name: amas
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  date       :datetime         not null
#  title      :string(255)      not null
#  content    :text
#  karma      :integer          default(0)
#  user_id    :integer          not null
#  permalink  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comments   :integer          default(0)
#  responses  :integer          default(0)
#

require 'api/reddit.com'
class Ama < ActiveRecord::Base

  # Basic validations
  validates_presence_of :key, :permalink, :title, :user_id
  validates_uniqueness_of :key

  # has one "user" as the owner of the AMA
  belongs_to :user, :touch => true

  # has many "users", that are guest speakers
  has_and_belongs_to_many :users

  # can be tagged using "acts_as_taggable" gem
  acts_as_taggable

  # AMA 'comments'
  has_many :children, -> { where order: 'karma DESC' }, class_name: 'Comment', primary_key: :key, foreign_key: :parent_key

  # paper_trail gem to record changes to content attribute
  has_paper_trail :only => :content, :on => [:update, :destroy]

  # Update OP caches
  # after_save :update_ops

  # Update tagging karma score
  after_save :update_taggings

  def to_param
    key
  end
  
  # Fetch AMA JSON from Reddit API
  def fetch
    begin
      reddit = Reddit.new
      response = reddit.getAMA(self.key)
      if response
        self.find_responses(response[1]["data"]["children"], '-')
        self.update_by_json(response[0]["data"]["children"][0]["data"])
      else
        puts "FAILED AMA FETCH #{self.key}"
      end
    end
  end
  
  # Creates an AMA record.
  # Expects the record "data" from reddit.com api json.
  # returns ama
  def create_by_json(json)
    self.attributes = {
        :key => json["id"],
        :date => Time.at(json["created_utc"]),
        :title => json["title"].to_s.truncate(250, :omission => "..."),
        :karma => json["score"],
        :user_id => User.find_or_create_by(username: json["author"]).id,
        :permalink => json["permalink"],
        :content => HTMLEntities.new.decode(json["selftext_html"]),
        :comments => json["num_comments"],
        :responses => 0
      }   
    return self.save ? self : false
  end

  protected

  # After an AMA is updated,
  # update all associated entities.
  # Which ultimately updates entity.cache_key
  def update_ops

    # Owner entity
    self.user.ops.each do |e|
      e.touch
    end

    # Entities participating
    self.users.each do |u|
      u.ops.each do |e|
        e.touch
      end
    end

  end

  # Update Tagging's karma
  def update_taggings
    self.taggings.each do |tagging|
      tagging.update_attribute(:karma, self.karma)
    end
  end
  
  # Updates an AMA from Reddit AMA JSON
  def update_by_json(json)
    
    #The sum of OP & Participant comments
    op_responses = Comment.where(:ama_id => self, :user_id => self.user).count
    participants_responses = Comment.where(:ama_id => self, :user_id => self.users).count
    responses = op_responses + participants_responses
    
    if responses == 0
      responses = -1
    end
    
    self.update_attributes(
      :karma => json["score"],
      :content => HTMLEntities.new.decode(json["selftext_html"]),
      :comments => json["num_comments"],
      :responses => responses
    )
  end
  
  # Recursive function, which selects and saves relevant responses.
  def find_responses(posts, depth)
    
    has_op_child = false
    
    posts.each do |post|
      
      if post["kind"] != "more"
        
        keep_post = false
        is_op = false
        
        if post["data"]["author"] == self.user.username
          is_op = true
        elsif self.users.any? { |u| u.username == post["data"]["author"] }
          is_op = true
        end
        
        begin
          if post["data"].has_key?("replies") and post["data"]["replies"] != ''
            keep_post = self.find_responses(post["data"]["replies"]["data"]["children"], depth + '-')
          end
        end
        
        if keep_post || is_op
          has_op_child = true
          comment = Comment.find_by_key(post["data"]["id"])
          if comment
            comment.update_by_json(post["data"])
            # puts depth + ' [' + post["data"]["author"] + '] UPDATED'
          else
            comment = Comment.new
            comment.create_by_json(self.id, post["data"])
            # puts depth + ' [' + post["data"]["author"] + '] SAVED'
          end
        else
          # puts depth + ' ' + post["data"]["author"]
        end
      end
    end
    
    return has_op_child
  end
end
