Bestofama::Application.routes.draw do

  namespace :admin do
    resources :admins
    resources :amas do
      resources :comments
      resources :users, :controller => :amas_users
      collection do
        get ':id/clean', :action => :clean, :as => :clean
      end
    end
    resources :ops do
      resources :users, :controller => :ops_users
      resources :links, :controller => :ops_links
    end
    resources :users
    resources :trashes
    resources :tags
    resources :meta
    resources :upcomings
    resources :versions do
      collection do
        post ':id/revert', :action => :revert, :as => 'revert'
      end
    end
  end

end
