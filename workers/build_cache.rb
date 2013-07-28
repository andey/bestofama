require "net/http"
require 'open-uri'

start = Time.now
begin
  path = params[:path]
  puts "Rebuild Cache"
  puts "Path: #{path}"

  http = Net::HTTP.new("bestofama.herokuapp.com")
  request = Net::HTTP::Get.new("http://bestofama.herokuapp.com#{path}")
  response = http.request(request)
  puts "HTTP Code: #{response.code}"
rescue
  puts "FAILED"
ensure
  puts "Time Elapsed: #{Time.now - start}"
end