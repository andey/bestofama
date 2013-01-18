module CacheBuilder

  class << self

    require 'net/http'
    require 'open-uri'
    include AmasHelper
    include Rails.application.routes.url_helpers

    # Visit bestofama.com to build the cache
    def build_ama(a)
      http = Net::HTTP.new('bestofama.com')
      request = Net::HTTP::Get.new('http://bestofama.com' + ama_path(a))
      return http.request(request)
    end

  end
end
