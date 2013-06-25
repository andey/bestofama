namespace :update do

  # Update Ops rankings statistics
  task :op => :environment do

    # select Op
    @op = Op.where(:comment_karma => 0, :wikipedia_hits => 0).first
    @op ||= Op.order(:updated_at).first
    @op.touch
    puts "UPDATE ENTITY: #{@op.name}"

    url = @op.links.where(:site_id => 1).first

    #acquire
    if url
      require 'api/stats.grok.se'
      slug = url.link.match(/([^\/]*)$/)[1]
      stats = Grokse.get("http://stats.grok.se/json/en/latest90/#{slug}")
      sum = stats['daily_views'].values.sum
      @op.update_attribute(:wikipedia_hits, sum)
    end

    #update Reddit users link and comment karma
    require 'api/reddit'
    link_karma = 0
    comment_karma = 0
    @op.users.uniq.each do |user|
      json = Reddit.get("http://www.reddit.com/user/#{user.username}/about.json")
      link_karma += json["data"]["link_karma"].to_i
      comment_karma += json["data"]["comment_karma"].to_i
      user.update_attributes(:link_karma => json["data"]["link_karma"], :comment_karma => json["data"]["comment_karma"])
    end
    @op.update_attributes(:link_karma => link_karma, :comment_karma => comment_karma)
  end

  # Finally check of AMAs within 5 days old
  task :ama_hourly => :environment do
    require 'api/reddit'
    require 'cache_builder'

    @ama = Ama.where("date > ?", Time.now - 5.days).order(:updated_at).first
    if @ama
      Reddit.populate_ama(@ama)
      request = CacheBuilder.build_ama(@ama)
      puts request.code
    end
  end

  # Rapidly update new AMAs
  task :ama_rapid => :environment do
    require 'api/reddit'
    require 'cache_builder'

    @ama = Ama.where("date > ?", Time.now - 12.hours).order(:updated_at).first
    if @ama
      Reddit.populate_ama(@ama)
      request = CacheBuilder.build_ama(@ama)
      puts request.code
    end
  end

  task :upcoming => :environment do
    google = 'http://www.google.com/calendar/feeds/amaverify@gmail.com/public/full?orderby=starttime&max-results=100&singleevents=true&sortorder=ascending&futureevents=true&alt=json'
    http = Net::HTTP.new("www.google.com")
    request = Net::HTTP::Get.new(google)
    response = http.request(request)
    json = JSON.parse(response.read_body)

    json["feed"]["entry"].each do |entry|
      url = entry['id']['$t'].to_s
      title = entry['title']['$t'].to_s
      content = entry['content']['$t'].to_s
      date = entry['gd$when'][0]['startTime']
      Upcoming.create(:title => title, :description => content, :date => date, :url => url)
    end
  end
end