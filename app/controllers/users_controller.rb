class UsersController < ApplicationController
  layout 'v3'

  # GET /users/:id
  #
  # Show basic information about the user, and list all AMAs hosted/participated in.
  # Link to reddit.com user can be found on this page as well.
  def show
    @user = User.find_by_username(params[:id]) || raise_404

    respond_to do |format|
      format.html { if @user.belongs_to_only_one_op? then redirect_to op_path(@user.ops.first) end }
    end
  end

  private
  def default_url_options
    {:host => "bestofama.com"}
  end
end
