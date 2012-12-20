class Admin::EntitiesController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  # GET /entities
  def index
    @entities = Entity.order(:id).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /entities/1
  def show
    @entity = Entity.find_by_slug(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /entities/new
  def new
    @entity = Entity.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /entities/1/edit
  def edit
    @entity = Entity.find_by_slug(params[:id])
  end

  # POST /entities
  def create
    @entity = Entity.new(params[:entity])

    respond_to do |format|
      if @entity.save
        format.html { redirect_to admin_entity_path(@entity), :notice => 'Entity was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /entities/1
  def update
    @entity = Entity.find_by_slug(params[:id])

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to admin_entity_path(@entity), :notice => 'Entity was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /entities/1
  def destroy
    @entity = Entity.find_by_slug(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to admin_entities_url }
    end
  end

  def delete_user
    @entity = Entity.find_by_slug(params[:id])
    @user   = User.find_by_username(params[:username])
    @entity.users.delete(@user)

    respond_to do |format|
      format.html { redirect_to admin_entity_path(@entity) }
    end
  end
end
