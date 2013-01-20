module EntitiesHelper

  # Display mondal edit box if logged in.
  # If not, redirect user to login form.
  def entity_edit_path()
    if current_user_session
      return '#edit-box'
    else
      return '/session/login?return_to=' + entity_path(@entity)
    end
  end

  def entity_snippet_key(entity)
    return entity.cache_key + '/snippet'
  end

end
