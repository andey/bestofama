class AmasController < ApplicationController
  layout 'v3'

  # GET /amas
  #
  # List AMAs, can be ordered by:
  # - date (default)
  # - comments count
  # - responses count
  def index
    @order = (['karma', 'comments', 'responses'].include? params[:order]) ? params[:order] : 'date'
    @amas = Ama.where('responses > ?', 0).order(@order).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  # GET /amas/:id
  #
  # Show an AMA
  # - Comments are cached and built in the view
  # - @users are users who "participated" (guest speakers) in an AMA.
  def show
    @ama = Ama.find_by_key(params[:id]) || raise_404
    @users = @ama.users
    @ops = @ama.ops
    @changes = PaperTrail::Version.where(item_type: ['Comment'], item_id: Comment.where(ama_id: @ama).map(&:id)).order(:id).reverse_order

    respond_to do |format|
      format.html
    end
  end

end
