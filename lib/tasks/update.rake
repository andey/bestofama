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
      grokse = Grokse.new
      stats = grokse.latest90(slug)
      if stats
        sum = stats['daily_views'].values.sum
        @op.update_attribute(:wikipedia_hits, sum)
      end
    end

    #update Reddit users link and comment karma
    require 'api/reddit.com'
    link_karma = 0
    comment_karma = 0
    @op.users.uniq.each do |user|
      reddit = Reddit.new
      json = reddit.getUser(user.username)
      link_karma += json["data"]["link_karma"].to_i
      comment_karma += json["data"]["comment_karma"].to_i
      user.update_attributes(:link_karma => json["data"]["link_karma"], :comment_karma => json["data"]["comment_karma"])
    end
    @op.update_attributes(:link_karma => link_karma, :comment_karma => comment_karma)
  end

  task :ama, [:hours] => [:environment] do |t, args|
    @ama = Ama.where("date > ?", Time.now - args[:hours].to_i.hours).order(:updated_at).first
    @ama.fetch() unless !@ama
  end

  task :old_ama => :environment do
    @ama = Ama.order(:updated_at).first
    puts @ama.title
    @ama.fetch() unless !@ama
  end

  task :upcoming => :environment do
    google = 'http://www.google.com/calendar/feeds/amaverify@gmail.com/public/basic?orderby=starttime&sortorder=ascending&futureevents=true&alt=json'
    http = Net::HTTP.new("www.google.com")
    request = Net::HTTP::Get.new(google)
    response = http.request(request)
    json = JSON.parse(response.read_body)

    json["feed"]["entry"].each do |entry|

      u = Upcoming.new
      u.url = entry['id']['$t'].to_s
      u.description = entry['content']['$t'].to_s
      u.title = entry['title']['$t'].to_s

      if u.title =~ /\[([^\]]*)\]\(([^\)]*)\)/
        match = u.title.match(/\[([^\]]*)\]\(([^\)]*)\)/)
        u.name = match[1]
        u.wikipedia = match[2]
      end

      u.save
    end
  end

  # Update Tag with DuckDuckGo abstract definition
  task :tag => :environment do
    require 'api/duckduckgo.com'
    @tag = Tag.where(:meaningless => nil, :description => nil).first
    if @tag
      begin
        puts "----------------------------"
        puts "Updating Tag: #{@tag.name}"

        duckduckgo = DuckDuckGo.new
        result = duckduckgo.search(@tag.name)
        if result["AbstractSource"] == 'Wikipedia'
          puts "Set the AbstractSource"
          @tag.update_attribute(:wikipedia_url, result["AbstractURL"])
        end

        if result["AbstractText"] != ''
          puts "Used AbstractText"
          @tag.update_attribute(:description, result["AbstractText"].truncate(250, :omission => "..."))
        elsif result["RelatedTopics"] && result["RelatedTopics"][0]
          puts "Used Related Topics"
          @tag.update_attribute(:description, result["RelatedTopics"][0]["Text"].truncate(250, :omission => "..."))
        else
          puts "??????????"
          @tag.update_attribute(:meaningless, true)
        end
      rescue
        @tag.update_attribute(:meaningless, true)
      ensure
        puts "done"
      end
    end
  end
end