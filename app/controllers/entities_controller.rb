class EntitiesController < ApplicationController
  layout 'public'

  def show
    @entity = Entity.find_by_slug(params[:slug])
    @amas = Ama.where('responses > 0').where(:user_id => @entity.users).order(:date).reverse_order

    respond_to do |format|
      format.html
    end
  end

  def index
    @entities = Entity.order(:updated_at).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
    end
  end
end

