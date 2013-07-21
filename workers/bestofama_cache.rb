require 'pg'
require 'yaml'
require 'iron_core'
require 'iron_cache'
require 'iron_worker_ng'

ama_key = payload
puts "================="
puts "AMA: #{ama_key}"

client = IronCache::Client.new
bucket = client.cache("rails_cache")

#bucket.put("test_item", "Hello, World!")

db = YAML.load_file(".pg.yaml")
conn = PG::Connection.new(:host => db["host"], :port => db["port"], :dbname => db["dbname"], :user => db["user"], :password => db["password"])
conn.send_query( "SELECT * FROM amas WHERE key = '#{ama_key}' LIMIT 1" )

loop do
  res = conn.get_result or break
  res.check
  res.each do |row|
    updated_at = Time.parse(row['updated_at'])
    timestamp = updated_at.utc.strftime('%Y%m%d%H%M%S%9N')
    cache_key = "views/comments/amas/#{row['id']}-#{timestamp}"
    puts cache_key
    puts bucket.get(cache_key)
  end
end
