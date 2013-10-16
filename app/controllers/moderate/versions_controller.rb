class Moderate::VersionsController < ApplicationController
  http_basic_authenticate_with :name => ENV["ADMIN_USER"], :password => ENV["ADMIN_PASS"]
  layout 'v3-admin'

  def index
    @versions = Version.order(:created_at).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @version = Version.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def revert
    @version = Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end
    redirect_to admin_versions_path
  end
end
