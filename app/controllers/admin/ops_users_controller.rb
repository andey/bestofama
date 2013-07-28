class Admin::OpsUsersController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  layout 'v3-admin'

  # GET entities/:op_id/users/new
  def new
    @op = Op.find_by_slug(params[:op_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST entities/:op_id/users
  def create
    @op = Op.find_by_slug(params[:op_id])
    @user = User.find_by_username(params[:username])

    respond_to do |format|
      if @user
        @op.users << @user
        format.html { redirect_to admin_op_path(@op), :notice => 'User was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /entities/:op_id/users/:id
  def destroy
    @op = Op.find_by_slug(params[:op_id])
    @user = User.find_by_username(params[:id])
    @op.users.destroy(@user)

    @user.amas.each do |ama|
      expire_fragment(ama, options=nil)
    end

    respond_to do |format|
      format.html { redirect_to admin_op_path(@op) }
    end
  end
end
