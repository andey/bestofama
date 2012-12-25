Bestofama::Application.routes.draw do

  namespace :admin do
    resources :admins
    resources :comments
    resources :amas do
      collection do
        get ':id/clean', :action => :clean, :as => :clean
      end
    end
    resources :entities do
      resources :users, :controller => :entities_users
      collection do
        delete ':id/user/:username', :action => :delete_user, :as => :delete_user
      end
    end
    resources :users
  end

  namespace :api do
    get 'ama/find_by_key', :controller => :amas, :action => :find_by_key
    get 'entities/find_by_wiki_slug', :controller => :entities, :action => :find_by_wiki_slug
  end

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
  post 'submit', :controller => :amas, :action => :create
  get 'submit', :controller => :amas, :action => :new, :as => :submit
  get ":id" => 'pages#show', :as => :page, :format => false
  root :to => 'tags#index'
end
