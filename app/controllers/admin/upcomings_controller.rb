class Admin::UpcomingsController < ApplicationController
  http_basic_authenticate_with :name => 'admin', :password => 'password'
  layout 'v3-admin'

  # GET /meta
  def index
    @upcomings = Upcoming.all.reverse_order

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /meta/1
  def show
    @upcoming = Upcoming.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /meta/new
  def new
    @upcoming = Upcoming.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /meta/1/edit
  def edit
    @upcoming = Upcoming.find(params[:id])
  end

  # POST /meta
  def create
    @upcoming = Upcoming.new(params[:upcoming].permit!)

    respond_to do |format|
      if @upcoming.save
        format.html { redirect_to admin_upcoming_path(@upcoming), notice: 'Upcoming was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /meta/1
  def update
    @upcoming = Upcoming.find(params[:id])

    respond_to do |format|
      if @upcoming.update_attributes(params[:upcoming].permit!)
        format.html { redirect_to admin_upcoming_path(@upcoming), notice: 'Upcoming was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /meta/1
  def destroy
    @upcoming = Upcoming.find(params[:id])
    @upcoming.delete

    respond_to do |format|
      format.html { redirect_to admin_upcomings_path }
    end
  end
end
