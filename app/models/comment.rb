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
#  parent_id  :integer
#

class Comment < ActiveRecord::Base

  # Correct all "/r/subreddit" internal links within comments
  before_save :correct_reddit_relative_links
  def correct_reddit_relative_links
    matches = self.content.match(/href="(\/r\/[a-zA-Z0-9]*)"/)
    if matches
      self.content = self.content.gsub('href="' + matches[1], 'href="http://www.reddit.com' + matches[1])
    end
  end

  attr_accessible :ama_id, :content, :date, :key, :parent_id, :parent_key, :user_id, :karma
  belongs_to :user
  validates_presence_of :ama_id, :key, :parent_key, :user_id
  validates_uniqueness_of :key
end
