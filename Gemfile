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
gem 'bootstrap-will_paginate'
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

group :heroku do
  gem 'rails_12factor'
end

group :production do
  gem 'newrelic_rpm'
  gem 'iron_cache_rails'
end

group :development do
  gem 'annotate'
end

group :development, :test do
  gem 'awesome_print'
  gem 'rspec-rails'
end

group :test do
  gem 'sqlite3'
  gem 'factory_girl_rails', :require => false
  gem 'capybara'
end
