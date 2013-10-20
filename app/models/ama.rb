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
require 'iron_worker_ng'

class Ama < ActiveRecord::Base

  # Basic validations
  validates_presence_of :key, :permalink, :title, :user_id
  validates_uniqueness_of :key

  # has one "user" as the owner of the AMA
  belongs_to :user, :touch => true

  # has many "users", that are guest speakers
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users, :allow_destroy => true, :reject_if => lambda { |l| l[:username].blank? }

  # How to deal with user nested attributes
  def users_attributes=(users)
    users.values.each do |params|
      user = User.find_or_create_by(username: params[:username])
      params[:_destroy].to_i == 1 ? self.remove_user(user) : self.add_user(user)
    end
  end

  # can be tagged using "acts_as_taggable" gem
  acts_as_taggable

  # AMA 'comments'
  has_many :children, -> { where order: 'karma DESC' }, class_name: 'Comment', primary_key: :key, foreign_key: :parent_key

  # paper_trail gem to record changes to content attribute
  has_paper_trail :only => :content, :on => [:update, :destroy]

  # Update OP caches
  # after_save :update_ops

  # Update tagging karma score
  after_save :update_taggings, :build_cache

  # Moderation Queue
  scope :queue, -> { where 'amas.id NOT IN ( SELECT taggable_id from taggings ) AND amas.user_id NOT IN ( SELECT user_id from ops_users )' }

  # Tagless AMAs
  scope :tagless, -> { where 'amas.id NOT IN ( SELECT taggable_id from taggings )' }

  # Opless AMAs
  scope :opless, -> { where 'amas.user_id NOT IN ( SELECT user_id from ops_users )' }

  def to_param
    key
  end

  # Fetch AMA JSON from Reddit API
  def fetch
    begin
      reddit = Reddit.new
      response = reddit.getAMA(self.key)
      if response
        Archive.create(key: self.key, timestamp: Time.now, reponse: response) rescue "Failed to Archive AMA #{self.key}"
        self.find_responses(response[1]["data"]["children"])
        self.update_by_json(response[0]["data"]["children"][0]["data"])
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

  # Trash an AMA
  def trash
    Comment.where(:ama_id => self.id).destroy_all
    Trash.create(:key => self.key)
    self.destroy
  end

  # Add an user to AMA
  def add_user(user)
    self.users << user unless self.users.include?(user)
  end

  # Remove user from AMA
  def remove_user(user)
    self.users.destroy(user)
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

  def build_cache
    client = IronWorkerNG::Client.new(token: ENV['IRON_CACHE_TOKEN'], project_id: ENV['IRON_CACHE_PROJECT_ID'])
    client.tasks.create( 'build_cache', :ama => self.key )
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

  # Is the username an OP or a notable participant?
  def is_op?(username)
    username == self.user.username || self.users.any? { |u| u.username == username }
  end

  # Find or Create comment from Reddit JSON
  def find_or_create_comment_by_json(data)
    comment = Comment.find_by_key(data["id"])
    if comment
      comment.update_by_json(data)
    else
      comment = Comment.new
      comment.create_by_json(self.id, data)
    end
  end

  # Should this comment be saved?
  def comment_has_children?(data)
    if data.has_key?("replies") and data["replies"] != ''
      return self.find_responses(data["replies"]["data"]["children"])
    else
      return false
    end
  end

  # Recursive function, which selects and saves relevant responses.
  def find_responses(posts)
    has_op_child = false

    posts.each do |post|
      if post["kind"] != "more" && ( self.comment_has_children?(post["data"]) || self.is_op?(post["data"]["author"]) )
        has_op_child = true
        self.find_or_create_comment_by_json(post["data"])
      end
    end

    return has_op_child
  end
end
