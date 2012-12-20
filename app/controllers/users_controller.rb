class UsersController < ApplicationController
  layout 'public'

  # GET /users/:username
  def show
    @user = User.find_by_username(params[:username])
    @amas = @user.amas.order(:date).reverse_order

    respond_to do |format|
      format.html
    end
  end
end
