source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.1.8'
gem 'pg'
gem 'unicorn' # puma was leaking memory
gem 'jquery-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'slim-rails'
gem 'slim', '2.0.2'
gem 'uglifier'
gem 'jbuilder'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'high_voltage'
gem 'acts-as-taggable-on'
gem 'htmlentities'
gem 'sitemap_generator'
gem 'carrierwave'
gem 'unf'
gem 'dalli'
gem 'fog'
gem 'paperclip', '3.5.4'
gem 'aws-sdk'
gem 'paper_trail', ' 3.0.5'
gem 'airbrake'
gem 'httparty'
gem 'meta-tags', :require => 'meta_tags'
gem 'activeadmin', github: 'activeadmin'
gem 'devise'
gem 'therubyracer'

group :heroku do
  gem 'rails_12factor'
end

group :production do
  gem 'newrelic_rpm'
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
