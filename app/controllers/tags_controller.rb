class TagsController < ApplicationController
  layout 'public'

  # HOME PAGE
  def index
    @amas = Ama.where('responses > ?', 0).order(:date).limit(5).reverse_order
  end

  # GET /tag/:tag
  def show
    if params[:tag]
      @entities = Entity.tagged_with(params[:tag])
    else
      @entities = Entity.all
    end

    respond_to do |format|
      format.html
    end
  end
end
