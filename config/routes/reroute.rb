Bestofama::Application.routes.draw do

  get 'entities' => redirect{ |p, request| "/ops?#{request.query_string}" }
  get 'entity/:slug' => redirect("/ops/%{slug}")

  get 'tag/:tag' => redirect("/tags/%{tag}")

  get 'r/:subreddit' => redirect('http://www.reddit.com/r/%{subreddit}')
  get 'u/:username' => redirect('http://www.reddit.com/u/%{username}')

  get 'user/:username' => redirect("/users/%{username}")
  get 'user/:username/ama/:key/:slug/' => redirect("/amas/%{key}")
  get ':entity/:key' => redirect('/amas/%{key}')

end
