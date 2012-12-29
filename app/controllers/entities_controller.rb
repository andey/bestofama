class EntitiesController < ApplicationController
  layout 'public'

  def show
    @entity = Entity.find_by_slug(params[:slug])
    @amas = Ama.where(:user_id => @entity.users).order(:date).reverse_order

    respond_to do |format|
      format.html
    end
  end
end

