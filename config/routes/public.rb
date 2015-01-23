Bestofama::Application.routes.draw do

  resources :amas, :path_names => { :new => 'submit' }
  resources :tags
  resources :users
  resources :ops
  root :to => 'amas#index'

end
