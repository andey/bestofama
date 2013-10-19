#== Wikipedia Stats API library

class Grokse
  include HTTParty
  base_uri 'stats.grok.se'

  def latest90(slug)
    response = self.class.get "/json/en/latest90/#{slug}"
    return response.code == 200 ? JSON.parse(response.body) : nil
  end
end