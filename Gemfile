source 'https://rubygems.org'

ruby '2.0.0'

gem "rails", "~> 4.0.0.rc2"
gem 'pg'
gem 'unicorn'
gem 'jquery-rails'
gem 'sass-rails', "~> 4.0.0.rc2"
gem 'coffee-rails'
gem 'slim-rails'
gem 'uglifier', '~> 1.3'
gem 'jbuilder', '~> 1.0.1'
gem 'will_paginate'
gem 'bootstrap-will_paginate', :git => 'git://github.com/yrgoldteeth/bootstrap-will_paginate.git'
gem "high_voltage", "~> 1.2.2"
gem "acts-as-taggable-on", "~> 2.4.1"
gem 'htmlentities'
gem 'sitemap_generator', '~> 3.4'
gem 'carrierwave'
gem 'fog'
gem 'paperclip'
gem 'aws-sdk'
gem 'paper_trail', :git => "git://github.com/airblade/paper_trail.git", :branch => "rails4"

group :production do
  gem 'newrelic_rpm'
  gem 'iron_cache_rails'
end

group :development do
  gem 'awesome_print'
end

group :heroku do
  gem 'rails_log_stdout', github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end

gem 'rspec-rails', :group => [:test, :development]
group :test do
  #gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'spork'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'rb-inotify', '~> 0.8.8'
end
