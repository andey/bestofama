class Api::AmasController < ApplicationController
  def find_by_key
    if params[:key]
      begin
        @ama = Ama.find_by_key(params[:key].parameterize)
        ama_path = ama_full_path(:username=> @ama.user.username, :key => @ama.key, :slug => @ama.title.parameterize)

        respond_to do |format|
          format.json { render :json => {:result => true, :ama => @ama, :link => ama_path}, :callback => params[:callback] }
          format.xml { render :xml => {:result => true, :ama => @ama, :link => ama_path}}
        end
      rescue
        respond_to do |format|
          format.json { render :json => {:result => false, :error => 'Could not find AMA'}, :callback => params[:callback] }
          format.xml { render :xml => {:result => false, :error => 'Could not find AMA'} }
        end
      end
    else
      respond_to do |format|
        format.json { render :json => {:result => false, :error => 'No search query given'}, :callback => params[:callback] }
        format.xml { render :xml => {:result => false, :error => 'No search query given'} }
      end
    end
  end
end
