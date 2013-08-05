class Admin::TagsController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  layout 'v3-admin'

  # GET /tags
  def index
    @tags = Tag.order(:name).paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # PUT /tags/1
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag].permit!)
        format.html { redirect_to admin_tags_path, notice: 'Tag was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
end
