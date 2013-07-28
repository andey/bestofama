module RedditHelper

  # Format reddit username link
  def reddit_user_path(username)
    return 'http://www.reddit.com/user/' + username
  end

  # Format reddit comment link
  def reddit_comment_path(permalink, key)
    return 'http://www.reddit.com' + permalink + 'c5' + key
  end

  # Format reddit ama link
  def reddit_ama_path(permalink)
    return 'http://www.reddit.com' + permalink
  end

end
