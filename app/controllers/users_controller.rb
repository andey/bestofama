class UsersController < ApplicationController
  layout 'public'

  # GET /users/:username
  #
  # Show basic information about the user, and list all AMAs hosted/participated in.
  # Link to reddit.com user can be found on this page as well.
  def show
    @user = User.find_by_username(params[:username])
    @amas = @user.amas.order(:date).reverse_order

    respond_to do |format|
      format.html
    end
  end
end
