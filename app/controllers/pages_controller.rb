class PagesController < HighVoltage::PagesController
  rescue_from ActionView::MissingTemplate do |exception|

    #check if entity exisits
    @entity = Entity.find_by_slug(params[:id].parameterize)
    if @entity
      redirect_to entity_path(@entity)
    else
      redirect_to root_path, :notice => "Page no longer exists"
    end
  end

  layout 'public'
end