class Api::EntitiesController < ApplicationController
  def find_by_wiki_slug
    if params[:q]
      begin
        @entity = Entity.find_by_slug(params[:q].parameterize)
        respond_to do |format|
          format.json { render :json => {:result => true, :entity => @entity, :link => entity_path(@entity)}, :callback => params[:callback] }
          format.xml { render :xml => {:result => true, :entity => @entity, :link => entity_path(@entity)} }
        end
      rescue
        respond_to do |format|
          format.json { render :json => {:result => false, :error => 'Could not find entity'}, :callback => params[:callback] }
          format.xml { render :xml => {:result => false, :error => 'Could not find entity'} }
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
