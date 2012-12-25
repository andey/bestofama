class Admin::EntitiesUsersController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  # GET entities/:entity_id/users
  def index
    @entity = Entity.find_by_slug(params[:entity_id])
    @users = @entity.users

    respond_to do |format|
      format.html
    end
  end

  # GET entities/:entity_id/users/new
  def new
    @entity = Entity.find_by_slug(params[:entity_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST entities/:entity_id/users
  def create
    @entity = Entity.find_by_slug(params[:entity_id])
    @user = User.find_by_username(params[:username])

    ap params
    ap @user

    respond_to do |format|
      if @user
        @entity.users << @user
        format.html { redirect_to admin_entity_path(@entity), :notice => 'User was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /entities/:entity_id/users/:id
  def destroy
    @entity = Entity.find_by_slug(params[:entity_id])
    @user = User.find_by_username(params[:id])
    @entity.users.destroy(@user)

    respond_to do |format|
      format.html { redirect_to admin_entity_path(@entity) }
    end
  end
end
