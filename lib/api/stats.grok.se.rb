module Grokse
  require 'net/http'
  require 'open-uri'
  require 'override/json'
  require 'htmlentities'

  class << self

    # generic http GET request, parses json
    # @return json
    def get(url)
      http = Net::HTTP.new("stats.grok.se")
      request = Net::HTTP::Get.new(url)
      response = http.request(request)
      return JSON.parse(response.read_body)
    end
  end
end