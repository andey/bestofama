class EntitiesController < ApplicationController
  layout 'public'

  def show
    @entities = Entity.where("name ilike ?", "#{params[:letter]}%")

    respond_to do |format|
      format.html
    end
  end
end

