Bestofama::Application.routes.draw do

  namespace :admin do
    resources :admins
    resources :comments
    resources :amas do
      resources :users, :controller => :amas_users
      collection do
        get ':id/clean', :action => :clean, :as => :clean
      end
    end
    resources :entities do
      resources :users, :controller => :entities_users
      resources :links, :controller => :entities_links
    end
    resources :users
    resources :trashes
    resources :meta
    resources :link_icons, :controller => :entities_links_icons
    resources :versions do
      collection do
        post ':id/revert', :action => :revert, :as => 'revert'
      end
    end
  end

end
