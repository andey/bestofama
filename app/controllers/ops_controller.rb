class OpsController < ApplicationController
  before_filter :require_user, :only => :update
  layout 'v3'

  # GET /ops/:id
  #
  # Display general information about the entity,
  # and list all the AMAs hosted and participated in as a guest speaker

  def show

    @op = Op.find_by_slug(params[:id]) || raise_404
    @amas = Ama.where('responses > 0').where(:user_id => @op.users).order(:date).reverse_order

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
    @order = params[:order]

    # Not all entities have a wikipedia page.
    # Therefore sort by comment_karma for all entities with wikipedia_hit = 0
    @order ||= 'wikipedia_hits, comment_karma'

    params[:page] ||= 1
    @ops = Op.order(@order).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
    end
  end
end

