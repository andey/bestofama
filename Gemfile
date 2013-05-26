source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', :git => "git://github.com/rails/rails.git"
gem 'pg'
gem 'thin'
gem 'turbolinks'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'sass-rails'
gem 'coffee-rails'
gem 'slim-rails'
gem 'uglifier', '~> 1.3'
gem 'jbuilder', '~> 1.0.1'
gem 'will_paginate'
gem 'bootstrap-will_paginate', :git => "git://github.com/yrgoldteeth/bootstrap-will_paginate.git"
gem 'high_voltage', :git => "git://github.com/thoughtbot/high_voltage.git"
gem 'acts-as-taggable-on', :git => "git://github.com/tvdeyen/acts-as-taggable-on.git", :branch => "rails4"
gem 'htmlentities'
gem 'awesome_print'
gem 'sitemap_generator', '~> 3.4'
gem 'carrierwave'
gem 'fog'
#gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git", :branch => "rails-4"
gem 'aws-sdk'
gem 'paper_trail', :git => "git://github.com/airblade/paper_trail.git", :branch => "rails4"

group :production do
  gem 'newrelic_rpm'
  gem 'iron_cache_rails'
end

gem 'rspec-rails', :group => [:test, :development]
group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'spork'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'rb-inotify', '~> 0.8.8'
end
