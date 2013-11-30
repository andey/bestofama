# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  ama_id     :integer          not null
#  key        :string(255)      not null
#  user_id    :integer          not null
#  content    :text
#  parent_key :string(255)      not null
#  date       :datetime         not null
#  karma      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base

  # Relations
  belongs_to :user
  belongs_to :ama
  belongs_to :parent, :class_name => 'Comment', :primary_key => :key, :foreign_key => :parent_key
  has_many :children, -> { where order: 'karma DESC' }, class_name: 'Comment', primary_key: :parent_key, foreign_key: :key

  # Validations
  validates_presence_of :ama_id, :key, :parent_key, :user_id
  validates_uniqueness_of :key

  # paper_trail gem to record changes to content attribute
  has_paper_trail :only => :content, :on => [:update, :destroy]

  # creates an AMA comment
  # returns comment
  def create_by_json(ama_id, json, relevant)
    data = {
        :ama_id => ama_id,
        :key => json["id"],
        :user_id => User.find_or_create_by(username: json["author"]).id,
        :content => HTMLEntities.new.decode(json["body_html"]),
        :parent_key => /_(.*)/.match(json["parent_id"])[1],
        :date => Time.at(json["created_utc"]),
        :karma => json["ups"].to_i - json["downs"].to_i,
        :relevant => relevant
      } 
    return Comment.create(data)
  end
  
  # updates an AMA comment
  # returns comment
  def update_by_json(json, relevant)
    data = {
        :content => HTMLEntities.new.decode(json["body_html"]),
        :date => Time.at(json["created_utc"]),
        :karma => json["ups"].to_i - json["downs"].to_i,
        :relevant => relevant
      }
    return self.update_attributes(data)
  end 
  
  # Will return Bootstrap 3.0.0 label class
  def which_label?
    if self.user_id == self.ama.user_id
      return 'label label-info'
    elsif self.ama.users.include?(self.user)
      return 'label label-warning'
    else
      return ''
    end
  end

end
