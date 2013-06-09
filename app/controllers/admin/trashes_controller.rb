class Admin::TrashesController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  layout 'v3-admin'

  # GET /trashes
  def index
    @trashes = Trash.order(:created_at).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /trashes/1
  def show
    @trash = Trash.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /trashes/new
  def new
    @trash = Trash.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /trashes/1/edit
  def edit
    @trash = Trash.find(params[:id])
  end

  # POST /trashes
  def create
    @trash = Trash.new(params[:trash])

    respond_to do |format|
      if @trash.save
        format.html { redirect_to admin_trash_path(@trash), notice: 'Trash was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /trashes/1
  def update
    @trash = Trash.find(params[:id])

    respond_to do |format|
      if @trash.update_attributes(params[:trash])
        format.html { redirect_to admin_trash_path(@trash), notice: 'Trash was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /trashes/1
  def destroy
    @trash = Trash.find(params[:id])
    @trash.destroy

    respond_to do |format|
      format.html { redirect_to admin_trashes_url }
    end
  end
end
