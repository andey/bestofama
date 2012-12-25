class EntitiesController < ApplicationController
  layout 'public'

  def show
    @entities = Entity.where("name ilike ?", "#{params[:letter]}%").order(:updated_at).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
    end
  end
end

