class Admin::MetaController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  layout 'v3-admin'

  # GET /meta
  def index
    @meta = Metum.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /meta/1
  def show
    @metum = Metum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /meta/new
  def new
    @metum = Metum.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /meta/1/edit
  def edit
    @metum = Metum.find(params[:id])
  end

  # POST /meta
  def create
    @metum = Metum.new(params[:metum])

    respond_to do |format|
      if @metum.save
        format.html { redirect_to admin_metum_path(@metum), notice: 'Metum was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /meta/1
  def update
    @metum = Metum.find(params[:id])

    respond_to do |format|
      if @metum.update_attributes(params[:metum])
        format.html { redirect_to admin_metum_path(@metum), notice: 'Metum was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /meta/1
  def destroy
    @metum = Metum.find(params[:id])
    @metum.delete

    respond_to do |format|
      format.html { redirect_to admin_meta_url }
    end
  end
end
