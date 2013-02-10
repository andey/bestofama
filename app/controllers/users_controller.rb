class UsersController < ApplicationController
  layout 'public'

  # GET /users/:username
  #
  # Show basic information about the user, and list all AMAs hosted/participated in.
  # Link to reddit.com user can be found on this page as well.
  def show
    @user = User.find_by_username(params[:username])

    respond_to do |format|
      if @user && @user.entities.count == 1
        format.html { redirect_to entity_path(@user.entities.first.slug), :status => :moved_permanently }
      elsif @user
        @amas = @user.amas.order(:date).reverse_order
        format.html
      else
        format.html { redirect_to root_path, :notice => "User does not exist" }
      end
    end
  end
end
