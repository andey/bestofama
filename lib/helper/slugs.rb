module Slugs
  require 'htmlentities'
  require 'cgi'

  class << self
    def encode(slug)
      slug = slug.to_s
      slug = HTMLEntities.new.encode(slug)
      slug = CGI::escape(slug)
      return slug
    end

    def decode(slug)
      slug = HTMLEntities.new.decode(slug)
      slug = CGI::unescape(slug)
      return slug
    end
  end
end
