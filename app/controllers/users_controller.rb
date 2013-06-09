class UsersController < ApplicationController
  layout 'v3'

  # GET /users/:id
  #
  # Show basic information about the user, and list all AMAs hosted/participated in.
  # Link to reddit.com user can be found on this page as well.
  def show
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      format.html
    end
  end
end
