# Finding new AMAs with a score over 100
# TODO automatically filter out "Requests"

task :find_new_amas => :environment do
  require 'api/reddit'
  result = Reddit.get("http://www.reddit.com/r/IAmA.json")
  result["data"]["children"].each do |a|
    if a["data"]["score"].to_i > 100
       Reddit.save_ama(a["data"])
    end
  end
end