module EntitiesHelper

  def entity_edit_path()
    if current_user_session
      return '#edit-box'
    else
      return '/session/login?return_to=' + entity_path(@entity)
    end
  end

end
