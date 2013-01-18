class TagsController < ApplicationController
  layout 'public'

  # GET /tags
  #
  # Tag index, ordered by tagging count

  def index
    @tags = Entity.tag_counts_on(:tags).order(:count, :name).reverse_order.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html
    end
  end

  # GET /tag/:tag
  #
  # list of entities tagged by :tag sortable by:
  # - wikipedia_hits
  # - comment_karma
  # - link_karma

  def show
    @order = params[:order]
    @order ||= 'wikipedia_hits, comment_karma'
    params[:page] ||= 1
    @entities = Entity.tagged_with(params[:tag]).order(@order).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
    end
  end
end
