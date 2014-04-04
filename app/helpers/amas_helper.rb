module AmasHelper

  # Prints the "up" and "down" triangles with the karma score in between.
  def karma_meter(karma)
    s = ''
    s += image_tag asset_path("triangle_up.svg"), :class => "up_vote", :alt => "triangle up vote"
    s += '<br /><b>' + karma.to_s + '</b><br />'
    s += image_tag asset_path("triangle_down.svg"), :class => "down_vote", :alt => "triangle down vote"
    return s
  end

  # Print the AMA comments
  def print_comments(parent, depth, ac=ActionController::Base.new())
    string = ''
    Comment.where(parent_key: parent.key, relevant: true).order(:karma).reverse_order.each do |comment|
      string += ac.render_to_string( :partial => 'comments/show', :locals => {:comment => comment, :depth => depth})
      string += print_comments(comment, depth + 1, ac)
    end
    return string
  end

  # Will return Bootstrap 3.0.0 label class
  def label(op_id, guests, user_id)
    if user_id == op_id
      return 'label label-info'
    elsif guests.include?(user_id)
      return 'label label-warning'
    else
      return ''
    end
  end
end