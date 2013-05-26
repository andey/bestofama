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
    resources :users
    resources :trashes
    resources :meta
    resources :upcomings
    resources :link_icons, :controller => :entities_links_icons
    resources :versions do
      collection do
        post ':id/revert', :action => :revert, :as => 'revert'
      end
    end
  end

end
