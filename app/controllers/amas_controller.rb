class AmasController < ApplicationController
  layout 'public'

  def index
    @order = params[:order]
    @order ||= 'date'
    params[:page] ||= 1
    @amas = Ama.where('responses > ?', 0).order(@order).reverse_order.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html
    end
  end

  def show
    @ama = Ama.find_by_key(params[:key])
    @users = @ama.users

    respond_to do |format|
      format.html
    end
  end

  def new
    @ama = Ama.new

    respond_to do |format|
      format.html
    end
  end

  def create
    require 'api/reddit'

    begin
      #if The minimum
      if params[:wiki_url] != '' || params[:ama_url] != ''
        #CREATE OR MATCH ENTITY
        entity_wiki_slug = params[:wiki_url].match('http:\/\/en.wikipedia.org\/wiki\/(.*)')[1]
        @entity = Entity.find_by_slug(entity_wiki_slug.parameterize)

        if !@entity && params[:name] != ''
          @entity = Entity.create(
              :name => params[:name],
              :slug => entity_wiki_slug.parameterize,
              :wikipedia_slug => entity_wiki_slug,
              :content => params[:content]
          )
        elsif !@entity
          @entity = Entity.create(
              :name => entity_wiki_slug.parameterize,
              :slug => entity_wiki_slug.parameterize,
              :wikipedia_slug => entity_wiki_slug,
              :content => ''
          )
        end

        #CREATE AMA
        ama_key = params[:ama_url].match('\/IAmA\/comments\/([a-z0-9]{5,6})\/')[1]
        @ama = Ama.find_by_key(ama_key)

        if !@ama
          @ama = Reddit.create_ama(ama_key)
        end

        #ASSOCIATE ENTITY with USER
        @entity.users << @ama.user

        respond_to do |format|
          format.html { redirect_to ama_full_path(:username => @ama.user.username, :key => @ama.key, :slug => @ama.title.parameterize) }
        end
      else
        respond_to do |format|
          format.html { redirect_to submit_path, :notice => "You have not filled all the required fields." }
        end
      end
    rescue
      respond_to do |format|
        format.html { redirect_to submit_path, :notice => "There was a problem with your submission." }
      end
    end
  end

end
