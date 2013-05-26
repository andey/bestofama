class Admin::AmasController < ApplicationController
  http_basic_authenticate_with :name => 'admin', :password => 'password'
  layout 'v3-admin'

  # GET /amas
  def index
    @amas = Ama.order(:date).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /amas/1
  def show
    @ama = Ama.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /amas/new
  def new
    @ama = Ama.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /amas/1/edit
  def edit
    @ama = Ama.find(params[:id])
  end

  # POST /amas
  def create
    @ama = Ama.new(params[:ama])

    respond_to do |format|
      if @ama.save
        format.html { redirect_to @ama, :notice => 'Ama was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /amas/1
  def update
    @ama = Ama.find(params[:id])

    respond_to do |format|
      if @ama.update_attributes(params[:ama])
        format.html { redirect_to admin_ama_path(@ama), :notice => 'Ama was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # GET /amas/1/clean
  # deletes all the comments from the ama,
  # then fetches the comments again.
  def clean
    require 'api/reddit'
    @ama = Ama.find(params[:id])
    @ama.update_attribute(:responses, 0)

    #repopulate the AMA
    Reddit.populate_ama(@ama)

    respond_to do |format|
      format.html { redirect_to admin_ama_path(@ama) }
    end
  end

  # DELETE /amas/1
  def destroy
    @ama = Ama.find(params[:id])

    #Delete Comments
    Comment.where(:ama_id => @ama.id).destroy_all

    #Add AMA key to Trash
    Trash.create(:key => @ama.key)

    @ama.destroy

    respond_to do |format|
      format.html { redirect_to admin_amas_url }
    end
  end
end
