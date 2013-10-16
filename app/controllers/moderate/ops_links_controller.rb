class Moderate::OpsLinksController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  layout 'v3-admin'

  # GET /entities_links/new
  def new
    @op = Op.find_by_slug(params[:op_id])
    @op_link = OpsLink.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /entities_links/1/edit
  def edit
    @op = Op.find_by_slug(params[:op_id])
    @op_link = OpsLink.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # POST /entities_links
  def create
    @op = Op.find_by_slug(params[:op_id])
    @op_link = OpsLink.new(params[:ops_link].permit!)
    @op_link.update_attribute(:op_id, @op.id)

    respond_to do |format|
      if @op_link.save
        format.html { redirect_to admin_op_path(@op), notice: 'Ops link was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /entities_links/1
  def update
    @op = Op.find_by_slug(params[:op_id])
    @op_link = OpsLink.find(params[:id])

    respond_to do |format|
      if @op_link.update_attributes(params[:ops_link].permit!)
        format.html { redirect_to admin_op_path(@op), notice: 'Ops link was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /entities_links/1
  def destroy
    @op = Op.find_by_slug(params[:op_id])
    @op_link = OpsLink.find(params[:id])
    @op_link.destroy

    respond_to do |format|
      format.html { redirect_to admin_op_path(@op) }
    end
  end
end