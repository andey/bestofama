#== DuckDuckGo Stats API library

class DuckDuckGo
  include HTTParty
  base_uri 'api.duckduckgo.com'

  def search(text)
    options = {:query => {:q => text.gsub(/-/, '+'), :format => 'json'}}
    response = self.class.get('/', options)
    return response.code == 200 ? JSON.parse(response.body) : nil
  end
end