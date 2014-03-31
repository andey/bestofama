class OpsController < ApplicationController
  layout 'v3'

  # GET /ops/:id
  #
  # Display general information about the entity,
  # and list all the AMAs hosted and participated in as a guest speaker
  def show
    @op = Op.find_by_slug(params[:id]) || raise_404
    @comments = Comment.where(:user_id => @op.users).order(:karma).reverse_order.limit(10)

    respond_to do |format|
      format.html
    end
  end


  # GET /ops
  #
  # Index of all the entities sortable by:
  # - wikipedia_hits
  # - comment_karma
  # - link_karma
  def index
    # Not all entities have a wikipedia page.
    # Therefore sort by comment_karma for all entities with wikipedia_hit = 0
    @order = (['name', 'name DESC', 'comment_karma', 'link_karma'].include? params[:order]) ? params[:order] : 'wikipedia_hits, comment_karma'
    @ops = Op.order(@order).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
    end
  end

  private
  def default_url_options
    {:host => "bestofama.com"}
  end
end

