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
    @ama = Ama.find(params[:id])
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

    if !params[:ama_url].empty?

      # Find Reddit.com Key
      ama_key = params[:ama_url].match('\/comments\/([a-z0-9]{5,6})\/')

      # If a key is found, and the key is not in the trash bin
      if ama_key && !Trash.find_by_key(ama_key[1])

        # Send to reddit api library to create @ama
        require 'api/reddit'
        @ama = Reddit.create_ama(ama_key[1])

        respond_to do |format|
          if @ama.save
            format.html { redirect_to ama_full_path(:username => @ama.user.username, :key => @ama.key, :slug => @ama.title.parameterize), :notice => "Thank you for your submission, this AMA has now been put in the process queue." }
          else
            @ama = Ama.find_by_key(ama_key[1])
            format.html { redirect_to ama_full_path(:username => @ama.user.username, :key => @ama.key, :slug => @ama.title.parameterize), :notice => "AMA already added" }
          end
        end

        # fallback catch clause if no key was found, or key is in the trash bin
      else
        redirect_to submit_path, :notice => "Invalid or Blacklisted AMA"
      end
    else
      redirect_to submit_path, :notice => "No URL was submitted"
    end
  end

end
