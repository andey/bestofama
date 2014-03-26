source 'https://rubygems.org'

ruby '2.1.1'

gem "rails", "4.1.0.rc2"
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
gem 'unf'
gem 'fog'
gem 'paperclip', '3.5.4'
gem 'aws-sdk'
gem 'paper_trail', '>= 3.0.0.rc2'
gem 'airbrake'
gem 'httparty'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'iron_worker_ng'
gem 'meta-tags', :require => 'meta_tags'

group :heroku do
  gem 'rails_12factor'
end

group :production do
  gem 'newrelic_rpm'
  gem 'iron_cache_rails'
end

group :development do
  gem 'annotate'
  gem 'rdoc'
end

group :development, :test do
  gem 'awesome_print'
  gem 'rspec-rails'
end

group :test do
  gem 'factory_girl_rails', require: false
  gem 'capybara'
  gem 'coveralls', require: false
end
