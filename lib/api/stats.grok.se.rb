#== Wikipedia Stats API library

class Grokse
  include HTTParty
  base_uri 'stats.grok.se'

  def latest90(slug)
    response = self.class.get "/json/en/latest90/#{URI::DEFAULT_PARSER.escape(slug)}"
    return response.code == 200 ? JSON.parse(response.body) : nil
  end
end