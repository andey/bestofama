Bestofama::Application.routes.draw do

  resource :session, :controller => :user_sessions, :path_names => {:new => 'login'} do
    collection do
      get 'logout', :action => :destroy, :as => :logout
    end
  end
  get 'user/:username', :controller => :users, :action => :show, :as => :user
  get 'user/:username/ama/:key/:slug/', :controller => :amas, :action => :show, :as => :ama_full
  get 'entities/:letter', :controller => :entities, :action => :show, :as => :entities_letter
  get 'entity/:slug', :controller => :entity, :action => :show, :as => :entity
  get 'tag/:tag', :controller => :tags, :action => :show, :as => :tag
  get 'amas', :controller => :amas, :action => :index, :as => :amas
  post 'submit', :controller => :amas, :action => :create
  get 'submit', :controller => :amas, :action => :new, :as => :submit
  get 'sitemap_index.xml.gz', to: redirect('http://s3.bestofama.com/sitemaps/sitemap_index.xml.gz')
  get ":id" => 'pages#show', :as => :page, :format => false
  root :to => 'tags#index'

end
