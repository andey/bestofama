Bestofama::Application.routes.draw do

  namespace :api do
    get 'ama/find_by_key', :controller => :amas, :action => :find_by_key
    get 'entities/find_by_wiki_slug', :controller => :entities, :action => :find_by_wiki_slug
  end

end
