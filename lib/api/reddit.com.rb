#== Reddit.com API library

class Reddit
  include HTTParty
  #PROXY_CREDENTIALS = URI.parse(ENV['HTTP_PROXY'])
  base_uri 'www.reddit.com'
  #http_proxy PROXY_CREDENTIALS.host, PROXY_CREDENTIALS.port, PROXY_CREDENTIALS.user, PROXY_CREDENTIALS.password
  http_proxy '127.0.0.1', 8118

  def get(path)
    begin
      options = {:format => 'json', :headers => {'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36'}}
      response = self.class.get(path, options)
      return response.code == 200 ? JSON.parse(response.body) : nil
    rescue
      return nil
    end
  end

  def getAMA(key)
    return Rails.env == 'test' ? JSON.parse(File.read("spec/api/reddit.com/comments/#{key}.json")) : get("/comments/#{key}.json")
  end

  def getIAMAs
    return Rails.env == 'test' ? JSON.parse(File.read("spec/api/reddit.com/r/IAmA.json")) : get("/r/IAmA.json")
  end

  def getIP
    return get("https://api.ipify.org?format=json")
  end

  def getUser(username)
    return get "/user/#{username}/about.json"
  end
end