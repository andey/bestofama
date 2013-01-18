#== Static Pages
# Static pages are handled by "high_voltage" gem.
# Pages can be found in views/pages

class PagesController < HighVoltage::PagesController

  # If no static page is found
  rescue_from(ActionView::MissingTemplate) { |exception|

    # Check if entity exists.
    # Old URL structure has entities slug at the base of the URL structure
    @entity = Entity.find_by_slug(params[:id].parameterize)
    if @entity
      redirect_to entity_path(@entity)
    else
      redirect_to root_path, :notice => "Page no longer exists"
    end
  }

  layout 'public'
end