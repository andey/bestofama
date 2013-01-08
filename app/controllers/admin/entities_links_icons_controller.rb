class Admin::EntitiesLinksIconsController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  # GET /entities_links_icons
  def index
    @entities_links_icons = EntitiesLinksIcon.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /entities_links_icons/1
  def show
    @entities_links_icon = EntitiesLinksIcon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /entities_links_icons/new
  def new
    @entities_links_icon = EntitiesLinksIcon.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /entities_links_icons/1/edit
  def edit
    @entities_links_icon = EntitiesLinksIcon.find(params[:id])
  end

  # POST /entities_links_icons
  def create
    @entities_links_icon = EntitiesLinksIcon.new(params[:entities_links_icon])

    respond_to do |format|
      if @entities_links_icon.save
        format.html { redirect_to admin_link_icon_path(@entities_links_icon), notice: 'Entities links icon was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /entities_links_icons/1
  def update
    @entities_links_icon = EntitiesLinksIcon.find(params[:id])

    respond_to do |format|
      if @entities_links_icon.update_attributes(params[:entities_links_icon])
        format.html { redirect_to admin_link_icon_path(@entities_links_icon), notice: 'Entities links icon was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /entities_links_icons/1
  def destroy
    @entities_links_icon = EntitiesLinksIcon.find(params[:id])
    @entities_links_icon.destroy

    respond_to do |format|
      format.html { redirect_to admin_link_icons_url }
    end
  end
end
