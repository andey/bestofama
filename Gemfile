source 'https://rubygems.org'

ruby '2.0.0'

gem "rails", "~> 4.0.0"
gem 'pg'
gem 'unicorn'
gem 'jquery-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'slim-rails'
gem 'uglifier'
gem 'jbuilder'
gem 'will_paginate'
gem 'bootstrap-will_paginate', :git => 'git://github.com/yrgoldteeth/bootstrap-will_paginate.git' # Bootstrap 3
gem "high_voltage"
gem "acts-as-taggable-on"
gem 'htmlentities'
gem 'sitemap_generator'
gem 'carrierwave'
gem 'fog'
gem 'paperclip'
gem 'aws-sdk'
gem 'paper_trail', '>= 3.0.0.beta1'
gem 'airbrake'
gem 'httparty'

group :production do
  gem 'newrelic_rpm'
  gem 'iron_cache_rails'
end

group :development do
  gem 'awesome_print'
  gem 'annotate'
end

group :heroku do
  gem 'rails_12factor'
end

gem 'rspec-rails', :group => [:test, :development]
group :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'capybara'
end
