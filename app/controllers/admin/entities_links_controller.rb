class Admin::EntitiesLinksController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  # GET /entities_links
  def index
    @entity = Entity.find_by_slug(params[:entity_id])
    @entities_links = @entity.entities_links

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @entity = Entity.find_by_slug(params[:entity_id])
    @entities_link = EntitiesLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /entities_links/new
  def new
    @entity = Entity.find_by_slug(params[:entity_id])
    @entities_link = EntitiesLink.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /entities_links/1/edit
  def edit
    @entity = Entity.find_by_slug(params[:entity_id])
    @entities_link = EntitiesLink.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # POST /entities_links
  def create
    @entity = Entity.find_by_slug(params[:entity_id])
    @entities_link = EntitiesLink.new(params[:entities_link])
    @entities_link.update_attribute(:entity_id, @entity.id)

    respond_to do |format|
      if @entities_link.save
        format.html { redirect_to admin_entity_path(@entity), notice: 'Entities link was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /entities_links/1
  def update
    @entity = Entity.find_by_slug(params[:entity_id])
    @entities_link = EntitiesLink.find(params[:id])

    respond_to do |format|
      if @entities_link.update_attributes(params[:entities_link])
        format.html { redirect_to admin_entity_path(@entity), notice: 'Entities link was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /entities_links/1
  def destroy
    @entity = Entity.find_by_slug(params[:entity_id])
    @entities_link = EntitiesLink.find(params[:id])
    @entities_link.destroy

    respond_to do |format|
      format.html { redirect_to admin_entity_path(@entity) }
    end
  end
end
