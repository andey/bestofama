Bestofama::Application.routes.draw do

  # User Sessions
  resource :session, :controller => :user_sessions, :path_names => {:new => 'login'} do
    collection do
      get 'logout', :action => :destroy, :as => :logout
    end
  end

  # User path
  get 'user/:username', :controller => :users, :action => :show, :as => :user

  # AMA path
  get 'user/:username/ama/:key/:slug/', :controller => :amas, :action => :show, :as => :ama_full
  get 'amas', :controller => :amas, :action => :index, :as => :amas

  # Entity path
  get 'entity/:slug', :controller => :entities, :action => :show, :as => :entity

  # Tag path
  get 'tag/:tag', :controller => :tags, :action => :show, :as => :tag

  # Submissions
  post 'submit', :controller => :amas, :action => :create
  get 'submit', :controller => :amas, :action => :new, :as => :submit

  # Sitemap Redirect
  get 'sitemap_index.xml.gz', to: redirect('http://s3.bestofama.com/sitemaps/sitemap_index.xml.gz')

  # Pages
  get ":id" => 'pages#show', :as => :page, :format => false

  # Root
  root :to => 'tags#index'

end
