class TagsController < ApplicationController
  layout 'public'

  # HOME PAGE
  def index
    @tags = Entity.tag_counts_on(:tags).order(:count, :name).reverse_order.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html
    end
  end

  # GET /tag/:tag
  def show
    @entities = Entity.tagged_with(params[:tag]).order(:wikipedia_hits, :comment_karma).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
    end
  end
end
