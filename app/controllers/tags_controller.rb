class TagsController < ApplicationController
  layout 'v3'

  # GET /tags
  #
  # Tag index, ordered by tagging count

  def index
    params[:page] ||= 1
    @tags = Op.tag_counts_on(:tags, :order => "count desc").paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
      format.json { render json: @tags}
    end
  end

  # GET /tags/:id
  #
  # list of entities tagged by :tag sortable by:
  # - wikipedia_hits
  # - comment_karma
  # - link_karma

  def show
    @order = params[:order]
    @order ||= 'wikipedia_hits, comment_karma'
    params[:page] ||= 1
    @ops = Op.tagged_with(params[:id]).order(@order).reverse_order.paginate(:page => params[:page], :per_page => 25) || raise_404

    respond_to do |format|
      format.html
      format.json { render json: @entities}
    end
  end
end
