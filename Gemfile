source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '4.2.5'
gem 'pg'
gem 'unicorn' # puma was leaking memory
gem 'jquery-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'slim-rails'
gem 'slim'
gem 'uglifier'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'high_voltage'
gem 'acts-as-taggable-on'
gem 'htmlentities'
gem 'sitemap_generator'
gem 'unf' # This is a wrapper library to bring Unicode Normalization Form support to Ruby/JRuby.
gem 'dalli'
gem 'fog'
gem 'paperclip'
gem 'aws-sdk'
gem 'paper_trail'
gem 'httparty'
gem 'meta-tags', :require => 'meta_tags'
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
