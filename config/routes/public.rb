Bestofama::Application.routes.draw do

  resources :amas, :path_names => { :new => 'submit' }
  resources :tags
  resources :users
  resources :ops

  get 'r/:subreddit', to: redirect('http://www.reddit.com/r/%{subreddit}')
  get 'sitemap_index.xml.gz', to: redirect('http://s3.bestofama.com/sitemaps/sitemap_index.xml.gz')

  root :to => 'index#show'

end
