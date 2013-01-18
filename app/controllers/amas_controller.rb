class AmasController < ApplicationController
  layout 'public'

  # Used by routes to match old URL structure, and then redirect the user to the new current URL
  # - if a key is not found, then user will be redirected back to the root_path

  def redirect
    @ama = Ama.find_by_key(params[:key])
    if @ama
      redirect_to ama_full_path(:username => @ama.user.username, :key => @ama.key, :slug => @ama.title.parameterize), :status => :moved_permanently
    else
      redirect_to root_path, :notice => "AMA has been removed"
    end
  end

  # GET /
  #
  # The current root_path, which displays:
  # - 5 x AMAs over 1000 karma
  # - 5 x most recent AMAs

  def homepage
    @featured = Ama.where('responses > ? AND karma > ?', 0, 1000).order(:date).limit(5).reverse_order
    @recent = Ama.where('responses > ?', 0).order(:date).limit(5).reverse_order

    respond_to do |format|
      format.html
    end
  end

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

  # GET /user/:user_id/ama/:key/:title
  #
  # Show an AMA
  # - Comments are cached and built in the view
  # - @users are users who "participated" (guest speakers) in an AMA.

  def show
    @ama = Ama.find_by_key(params[:key])

    respond_to do |format|
      if @ama
        @users = @ama.users
        format.html
      else
        format.html { redirect_to root_path, :notice => "AMA has been removed" }
      end
    end
  end

  # GET /submit
  #
  # form to submit an AMA url
  def new
    @ama = Ama.new

    respond_to do |format|
      format.html
    end
  end

  # POST /submit
  #
  # expects params "ama_url"
  # will match and accept any url /comment/:key/
  def create

    # Find Reddit.com Key
    ama_key = params[:ama_url].match('\/comments\/([a-z0-9]{5,6})\/')[1]

    # If a key is found, and the key is not in the trash bin
    if params[:ama_url] != '' && !Trash.find_by_key(ama_key)

      # Send to reddit api library to create @ama
      require 'api/reddit'
      @ama = Reddit.create_ama(ama_key)

      respond_to do |format|
        if @ama.save
          format.html { redirect_to ama_full_path(:username => @ama.user.username, :key => @ama.key, :slug => @ama.title.parameterize), :notice => "Thank you for your submission, this AMA has now been put in the process queue." }
        else
          format.html { redirect_to submit_path, :notice => "Internal error, AMA was unable to save." }
        end
      end

    # fallback catch clause if no key was found, or key is in the trash bin
    else
      redirect_to submit_path, :notice => "Invalid or Blacklisted URL"
    end
  end
end
