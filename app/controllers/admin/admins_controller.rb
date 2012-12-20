class Admin::AdminsController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  # GET /admin/admins
  def index
    @admins = Admin.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /admin/admins/new
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /admin/admins
  def create
    @admin = Admin.new(params[:admin])

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_admins_path, notice: 'Admin was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # DELETE /admin/admins/1
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to admin_admins_path }
    end
  end
end
