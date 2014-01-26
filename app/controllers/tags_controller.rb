class TagsController < ApplicationController
  layout 'v3'

  # GET /tags
  #
  # Tag index, ordered by tagging count

  def index
    params[:page] ||= 1
    @tags = Tag.popular.paginate(:page => params[:page], :per_page => 24)
    @last_updated = Tag.order(:updated_at).reverse_order.first
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
    redirect_to tag_path(@tag.redirect_tag_name) if @tag.redirect_tag_id
    @taggings = @tag.taggings.order(:karma).reverse_order.paginate(:page => params[:page], :per_page => 25)
  end
end
