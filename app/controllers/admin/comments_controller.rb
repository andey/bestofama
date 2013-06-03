class Admin::CommentsController < ApplicationController
  http_basic_authenticate_with :name => 'admin', :password => 'password'
  layout 'v3-admin'

  # GET /comments
  def index
    @ama = Ama.find_by_key(params[:ama_id])
    @comments = Comment.where(:ama_id => @ama.id).order(:id).reverse_order.paginate(:page => params[:page], :per_page => 100)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /comments/1
  def show
    @ama = Ama.find_by_key(params[:ama_id])
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /comments/new
  def new
    @ama = Ama.find_by_key(params[:ama_id])
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /comments
  def create
    @ama = Ama.find_by_key(params[:ama_id])
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, :notice => 'Comment was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @ama = Ama.find_by_key(params[:ama_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to admin_ama_comments_path(@ama) }
    end
  end
end
