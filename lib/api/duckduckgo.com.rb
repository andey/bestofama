#== DuckDuckGo Stats API library

module DuckDuckGo
  require 'net/http'
  require 'open-uri'
  require 'override/json'
  require 'htmlentities'

  class << self

    # generic http GET request, parses json
    # @return json
    def get(url)
      http = Net::HTTP.new("api.duckduckgo.com")
      request = Net::HTTP::Get.new(url)
      response = http.request(request)
      return JSON.parse(response.read_body)
    end

    def search(word)
      return self.get("http://api.duckduckgo.com/?q=#{word.gsub(/-/, '+')}&format=json")
    end
  end
end