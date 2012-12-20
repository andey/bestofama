module AmasHelper
  def karma_meter(karma)
    s = ''
    s += image_tag asset_path("triangle_up.svg"), :class => "up_vote", :alt => "triangle up vote"
    s += '<br /><b>' + karma.to_s + '</b><br />'
    s += image_tag asset_path("triangle_down.svg"), :class => "down_vote", :alt => "triangle down vote"
    return s
  end

  def ama_path(a)
    return ama_full_path(:username=> a.user.username, :key => a.key, :slug => a.title.parameterize)
  end

  # Helps /IAmA/:key display the comments
  def print_comments(ama, parent, depth)
    string = ''
    Comment.where(:parent_key => parent.key).order(:karma).reverse_order.each do |comment|
      if comment.user_id == ama.user_id
        string += '<div class="row" style="margin-bottom: 5px;"><div class="span9 halfoffset' + depth.to_s + '"><p><span class="label label-info">' + link_to(comment.user.username, user_path(comment.user)) + '</span> <span class="muted">' + comment.karma.to_s + ' points, ' + time_ago_in_words(Time.now - (comment.date - ama.date)) + ' after</span></p>' + comment.content + '</div></div>' + print_comments(ama, comment, depth + 1)
      else
        string += '<div class="row" style="margin-bottom: 5px;"><div class="span9 halfoffset' + depth.to_s + '"><p><span>' + link_to(comment.user.username, reddit_user_path(comment.user.username), :rel => :nofollow) + '</span> <span class="muted">' + comment.karma.to_s + ' points, ' + time_ago_in_words(Time.now - (comment.date - ama.date)) + ' after</span></p>' + comment.content + '</div></div>' + print_comments(ama, comment, depth + 1)
      end
    end
    return string
  end

  def wiki_encode(slug)
    slug = slug.to_s
    slug = HTMLEntities.new.encode(slug)
    slug = CGI::escape(slug)
    return slug
  end

  def wiki_decode(slug)
    slug = HTMLEntities.new.decode(slug)
    slug = CGI::unescape(slug)
    return slug
  end
end
