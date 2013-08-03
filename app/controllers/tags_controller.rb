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
    params[:page] ||= 1
    @tag = Tag.find_by_name(params[:id]) || raise_404
    @taggings = @tag.taggings.order(:karma).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
      format.json { render json: @taggings}
    end
  end
end
