# Finding OLD AMAs that does not include the string "ama request"
task :find_old_amas => :environment do
  require 'api/reddit'
  puts ENV["count"]
  puts ENV["after"]
  result = Reddit.get("http://www.reddit.com/r/IAmA/top/.json?sort=top&count="+ ENV["count"] +"&after=" + ENV["after"] + "&t=all")
  result["data"]["children"].each do |a|
    if !a["data"]["title"].to_s.match(/ama request/i)
      puts a["data"]["title"]
      Reddit.save_ama(a["data"])
    end
  end
end