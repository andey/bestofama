# Entities are legal "entities" such as people, businesses, and organizations
class EntitiesController < ApplicationController
  before_filter :require_user, :only => :update
  layout 'public'

  # GET /entity/:slug
  #
  # Display general information about the entity,
  # and list all the AMAs hosted and participated in as a guest speaker

  def show
    @entity = Entity.find_by_slug(params[:slug])
    @amas = Ama.where('responses > 0').where(:user_id => @entity.users).order(:date).reverse_order

    respond_to do |format|
      format.html
    end
  end


  # GET /entities
  #
  # Index of all the entities sortable by:
  # - wikipedia_hits
  # - comment_karma
  # - link_karma

  def index
    @order = params[:order]

    # Not all entities have a wikipedia page.
    # Therefore sort by comment_karma for all entities with wikipedia_hit = 0
    @order ||= 'wikipedia_hits, comment_karma'

    params[:page] ||= 1
    @entities = Entity.order(@order).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
    end
  end

  # PUT /entity/:slug
  #
  # Before_filter is applied, requiring a current_user to update an entity.
  # NOTE: will accept nested attributes for EntitiesLinks

  def update
    @entity = Entity.find_by_slug(params[:slug])

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to entity_path(@entity), :notice => 'Entity was successfully updated.' }
      else
        format.html { redirect_to entity_path(@entity), :notice => 'Entity was unable to update.' }
      end
    end
  end
end

