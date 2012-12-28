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
    end
    resources :users
    resources :meta
  end

end
