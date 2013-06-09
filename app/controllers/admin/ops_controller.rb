class Admin::OpsController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  layout 'v3-admin'

  # GET /users
  def index
    @ops = Op.order(:updated_at).paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/1
  def show
    @op = Op.find_by_slug(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  def new
    @op = Op.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @op = Op.find_by_slug(params[:id])
  end

  # POST /users
  def create
    @op = Op.new(params[:user].permit!)

    respond_to do |format|
      if @op.save
        format.html { redirect_to admin_op_path(@op), :notice => 'Op was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  def update
    @op = Op.find_by_slug(params[:id])

    respond_to do |format|
      if @op.update_attributes(params[:user].permit!)
        format.html { redirect_to admin_op_path(@op), :notice => 'Op was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @op = Op.find_by_slug(params[:id])
    @op.destroy

    respond_to do |format|
      format.html { redirect_to ops_url }
    end
  end
end
