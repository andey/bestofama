module NavHelper
  def active_or_not?(bool)
    if bool
      return ''
    else
      return 'active'
    end
  end
end
