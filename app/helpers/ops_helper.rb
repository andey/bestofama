module OpsHelper

  # Parse wikipedia url, and return mobile url
  def wikipedia_mobile(full_url)
    match = /https?:\/\/en.(.*)/.match(full_url)
    if match[1]
      return "https://en.m.#{match[1]}"
    end
  end
end
