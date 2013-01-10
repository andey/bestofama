namespace :update do

  # Update Entities rankings statistics
  task :entity => :environment do

    # select Entity
    @entity = Entity.order(:updated_at).first
    url = @entity.entities_links.where(:entities_links_icon_id => 1).first

    #acquire
    if url
      require 'api/stats.grok.se'
      slug = url.link.match(/([^\/]*)$/)[1]
      stats = Grokse.get("http://stats.grok.se/json/en/latest90/#{slug}")
      sum = stats['daily_views'].values.sum
      @entity.update_attribute(:wikipedia_hits, sum)
    end

    #update Reddit users link and comment karma
    require 'api/reddit'
    link_karma = 0
    comment_karma = 0
    @entity.users.uniq.each do |user|
      json = Reddit.get("http://www.reddit.com/user/#{user.username}/about.json")
      link_karma += json["data"]["link_karma"].to_i
      comment_karma += json["data"]["comment_karma"].to_i
      user.update_attributes(:link_karma => json["data"]["link_karma"], :comment_karma => json["data"]["comment_karma"])
    end
    @entity.update_attributes(:link_karma => link_karma, :comment_karma => comment_karma)
  end
end