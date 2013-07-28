module OpsHelper
  def wikipedia_mobile(full_url)
    match = /http:\/\/en.(.*)/.match(full_url)
    if match[1]
      return "http://en.m.#{match[1]}"
    end
  end

  def twitter_mobile(full_url)
    match = /https:\/\/(.*)/.match(full_url)
    if match[1]
      return "https://mobile.#{match[1]}"
    end
  end
end
