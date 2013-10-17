Bestofama::Application.routes.draw do

  namespace :moderate do
    resources :ops do
      resources :users, :controller => :ops_users
      resources :links, :controller => :ops_links
    end
    resources :versions do
      collection do
        post ':id/revert', :action => :revert, :as => 'revert'
      end
    end
  end

end
