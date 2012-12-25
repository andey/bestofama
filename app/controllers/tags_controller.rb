class TagsController < ApplicationController
  layout 'public'

  # HOME PAGE
  def index
    @amas = Ama.where('responses > ?', 0).order(:date).limit(5).reverse_order
  end

  # GET /tag/:tag
  def show
    @entities = Entity.tagged_with(params[:tag]).order(:updated_at).reverse_order.paginate(:page => params[:page], :per_page => 25)
    @related_entities = Entity.tagged_with(params[:tag], :on => :tags)
    @related_tags = @related_entities.collect{|x|x.tags}.flatten.uniq

    respond_to do |format|
      format.html
    end
  end
end
