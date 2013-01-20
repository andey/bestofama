class Admin::UsersController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  # GET /users
  def index
    @users = User.order(:id).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/1
  def show
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /users/new
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by_username(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_path(@user), :notice => 'User was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /users/1
  def update
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_user_path(@user), :notice => 'User was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find_by_username(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end
end
