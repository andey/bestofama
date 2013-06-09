class Admin::AmasUsersController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  layout 'v3-admin'

  # GET entities/:ama_id/users
  def index
    @ama = Ama.find_by_key(params[:ama_id])
    @users = @ama.users

    respond_to do |format|
      format.html
    end
  end

  # GET entities/:ama_id/users/new
  def new
    @ama = Ama.find_by_key(params[:ama_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST entities/:ama_id/users
  def create
    require 'api/reddit'
    @ama = Ama.find_by_key(params[:ama_id])
    @user = Reddit.find_user(params[:username])

    respond_to do |format|
      if @user
        @ama.users << @user
        format.html { redirect_to admin_ama_path(@ama), :notice => 'User was successfully added.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /entities/:ama_id/users/:id
  def destroy
    @ama = Ama.find_by_key(params[:ama_id])
    @user = User.find_by_username(params[:id])
    @ama.users.destroy(@user)

    respond_to do |format|
      format.html { redirect_to admin_ama_path(@ama) }
    end
  end
end
