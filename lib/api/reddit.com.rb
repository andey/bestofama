#== Reddit.com API library

class Reddit
  include HTTParty
  base_uri 'www.reddit.com'

  def get(path)
    begin
      options = {:format => 'json', :headers => {'User-Agent' => 'bestofama.com / andey@reddit.com'}}
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

  def getUser(username)
    return get "/user/#{username}/about.json"
  end
end