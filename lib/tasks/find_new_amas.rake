# Finding new AMAs with a score over 100
task :find_new_amas => :environment do
  require 'api/reddit'
  result = Reddit.get("http://www.reddit.com/r/IAmA.json")
  result["data"]["children"].each do |a|
    if a["data"]["score"].to_i > 100 && !a["data"]["title"].to_s.match(/ama request/i) && !Trash.find_by_key(a["data"]["id"])
      Reddit.save_ama(a["data"])
    end
  end
end