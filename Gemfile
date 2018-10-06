source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# stuff I've added
gem 'bcrypt'
# gem 'bootstrap-sass', '3.3.7'
gem 'rails-controller-testing'
gem 'faker',  '1.8.4'
gem 'will_paginate', '3.1.6'
# gem 'will_paginate-bootstrap', '1.0.1'
gem 'rubocop', '~> 0.50.0', require: false
gem 'pry'
gem 'pry-rails'
gem 'carrierwave', '1.1.0'
gem 'mini_magick', '4.8.0'
gem 'fog', '1.42.0'
gem 'mutations'
gem "bulma-rails", "~> 0.6.1"
gem 'will_paginate-bulma'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'rails_real_favicon'
gem 'sidekiq'
gem 'intercom', '~> 3.5.23'
gem 'local_time'
gem "intercom-rails"
gem "retries"
gem "auto_strip_attributes", "~> 2.5"
gem 'state_of_the_nation'
gem "chartkick"
gem 'groupdate'
gem 'draper'
gem 'active_interaction', '~> 3.6.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.6'
  gem "rspec_junit_formatter"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
end

group :test do
  gem 'rspec-sidekiq'
  gem 'database_cleaner'
  gem 'timecop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby "2.4.1"
