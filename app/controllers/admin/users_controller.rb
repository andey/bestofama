class Admin::UsersController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  layout 'v3-admin'

  # GET /users
  def index
    @users = User.order(:updated_at).paginate(:page => params[:page], :per_page => 25)

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

  # DELETE /users/1
  def destroy
    @user = User.find_by_username(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_user_path }
    end
  end
end
