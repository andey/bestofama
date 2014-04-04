class UsersController < ApplicationController
  layout 'v3'

  # GET /users/:id
  #
  # Show basic information about the user, and list all AMAs hosted/participated in.
  # Link to reddit.com user can be found on this page as well.
  def show
    @user = User.find_by_username(params[:id]) || raise_404
    raise_404 if @user.id == 122 # the id of [deleted] user

    @comments = @user.comments.order(:karma).reverse_order.limit(5)
    # @participated = Ama.where(id: @comments.map(&:ama_id)).where.not(id: @user.amas)

    respond_to do |format|
      format.html { if @user.belongs_to_only_one_op? then redirect_to op_path(@user.ops.first) end }
    end
  end

  private
  def default_url_options
    {:host => "bestofama.com"}
  end
end
