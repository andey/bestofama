# Finding OLD AMAs that does not include the string "ama request"
task :find_old_amas => :environment do
  require 'api/reddit'

  #get query variables to build reddit query
  count = Metum.find_by_name("find_old_ama-count")
  after = Metum.find_by_name("find_old_ama-after")
  time = Metum.find_by_name("find_old_ama-time")

  puts "========================"
  puts "find_old_amas"
  puts "count: " + count.value
  puts "after: " + after.value

  result = Reddit.get("http://www.reddit.com/r/IAmA/top/.json?sort=top&count=" + count.value + "&after=" + after.value + "&t=" + time.value)
  result["data"]["children"].each do |a|

    #if not an "ama request"
    if a["data"]["score"].to_i > 100 && !a["data"]["title"].to_s.match(/ama request/i) && !Trash.find_by_key(a["data"]["id"])
      puts a["data"]["title"]
      Reddit.save_ama(a["data"])
    end
  end

  #update the query variables for the next run
  count.update_attribute(:value, count.value.to_i + 25)
  after.update_attribute(:value, result["data"]["after"])
end