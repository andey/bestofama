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
    @entities = Entity.order(:wikipedia_hits, :comment_karma).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
    end
  end

  # PUT /entity/:slug
  def update
    @entity = Entity.find_by_slug(params[:slug])

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to entity_path(@entity), :notice => 'Entity was successfully updated.' }
      else
        format.html { redirect_to entity_path(@entity), :notice => 'Entity was unable to update.' }
      end
    end
  end
end

