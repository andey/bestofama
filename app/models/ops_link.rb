# == Schema Information
#
# Table name: ops_links
#
#  id         :integer          not null, primary key
#  op_id      :integer
#  site_id    :integer
#  link       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OpsLink < ActiveRecord::Base

  SITES = [
      [0, 'ERROR', '!ERROR'],
      [1, 'Wikipedia', 'wikipedia.org'],
      [2, 'Twitter', 'twitter.com'],
      [3, 'Facebook', 'facebook.com'],
      [4, 'Linkedin', 'linkedin.com'],
      [5, 'Youtube', 'youtube.com'],
      [6, 'Google+', 'plus.google.com'],
      [7, 'MySpace', 'myspace.com'],
      [8, 'Tumblr', 'tumblr.com'],
      [9, 'IMDB', 'imdb.com']
  ]

  before_create :select_site
  validates_presence_of :link, :op_id, :site_id

  def site
    SITES[self.site_id][1]
  end

  private
  def select_site
    site_id = 0
    SITES.each_with_index do |site, i|
      if self.link.include?(site[2])
        site_id = site[0]
      end
    end
    self.site_id = site_id
  end
end
