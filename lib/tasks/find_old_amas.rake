# Finding OLD AMAs with a score over 100 and does not include the string "ama request"
task :find_old_amas => :environment do
  require 'api/reddit'
  puts ENV['url']
  begin
    result = Reddit.get(ENV['url'])
    result["data"]["children"].each do |a|
      if !a["data"]["title"].to_s.match(/ama request/i)
        Reddit.save_ama(a["data"])
      end
    end
  end
end