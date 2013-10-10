class AmasController < ApplicationController
  layout 'v3'

  # GET /amas
  #
  # List AMAs, can be ordered by:
  # - date (default)
  # - comments count
  # - responses count

  def index
    @order = params[:order]
    @order ||= 'date'
    params[:page] ||= 1
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

    respond_to do |format|
      format.html
    end
  end

  # GET /amas/new
  #
  # form to submit an AMA url
  def new
    @ama = Ama.new

    respond_to do |format|
      format.html
    end
  end

  # POST /amas
  #
  # expects params "ama_url"
  # will match and accept any url /comment/:key/
  def create

    # Redirect back to form if no URL was submitted
    redirect_to(submit_path, :notice => "No URL was submitted") if !params[:ama_url].empty? 

    # Match Reddit.com Key
    ama_key = params[:ama_url].match('\/comments\/([a-z0-9]{5,6})\/')

    # Redirect back to form if no key is found, or the key is in the trash bin
    redirect_to(submit_path, :notice => "Invalid or Blacklisted AMA") if !ama_key || Trash.find_by_key(ama_key[1])
    
    # Redirect back to AMA if it already exsits
    redirect_to(ama_path(@ama), :notice => "AMA already added") if Ama.exists?(key: ama_key)
    
    # Fetch AMA    
    response = Reddit.getAMA(ama_key)
    if response      
      @ama = Ama.new
      @ama = @ama.create_by_json(response[0]["data"]["children"][0]["data"])
      redirect_to ama_path(@ama), :notice => "Thank you for your submission, this AMA has now been put in the process queue."
    else
      redirect_to submit_path, :notice => "Unable to fetch AMA"
    end

  end
end
