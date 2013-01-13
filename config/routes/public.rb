Bestofama::Application.routes.draw do

  # User Sessions
  resource :session, :controller => :user_sessions, :path_names => {:new => 'login'} do
    collection do
      get 'logout', :action => :destroy, :as => :logout
    end
  end

  # User path
  get 'user/:username', :controller => :users, :action => :show, :as => :user

  # Entity path
  get 'entity/:slug', :controller => :entities, :action => :show, :as => :entity
  put 'entity/:slug', :controller => :entities, :action => :update
  get 'entities', :controller => :entities, :action => :index, :as => :entities

  # Tag path
  get 'tag/:tag', :controller => :tags, :action => :show, :as => :tag
  get 'tags', :controller => :tags, :action => :index, :as => :tags

  # Submissions
  post 'submit', :controller => :amas, :action => :create
  get 'submit', :controller => :amas, :action => :new, :as => :submit

  # Sitemap Redirect
  get 'sitemap_index.xml.gz', to: redirect('http://s3.bestofama.com/sitemaps/sitemap_index.xml.gz')

  # Redirect all u/:username and r/:subreddit links to reddit.com
  get 'r/:subreddit', to: redirect('http://www.reddit.com/r/%{subreddit}')
  get 'u/:username', to: redirect('http://www.reddit.com/u/%{username}')

  #Redirect old Directory Paths
  get 'directory/:category', to: redirect('/')

  # AMA path
  get 'user/:username/ama/:key/:slug/', :controller => :amas, :action => :show, :as => :ama_full
  get 'amas', :controller => :amas, :action => :index, :as => :amas
  get ':entity/:key', :controller => :amas, :action => :redirect, :constraint => {:entity => /^(?!.*admin).*$/} # old URL structure

  # Pages
  get ":id" => 'pages#show', :as => :page, :format => false

  # Root
  root :to => 'amas#homepage'

end
