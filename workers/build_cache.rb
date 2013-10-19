require "net/http"
require 'open-uri'

start = Time.now
ama = params[:ama]
puts "AMA: #{ama}"
http = Net::HTTP.new("bestofama.herokuapp.com")
request = Net::HTTP::Get.new("http://bestofama.herokuapp.com/amas/#{ama}")
response = http.request(request)
puts "HTTP Code: #{response.code}"
puts "Time Elapsed: #{Time.now - start}"