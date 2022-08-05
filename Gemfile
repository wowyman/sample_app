# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"
gem "erb-formatter"
gem "figaro"
gem "omniauth-facebook"
gem "omniauth", ">= 1.6.1"
gem "omniauth-google-oauth2", ">= 0.8.2"

gem "slack-notifier"
gem "whenever", :require => false

gem "devise", "~> 4.1"
gem "cancancan", "~> 3.0"
gem "rolify"
gem "rubyzip", require: "zip"
gem "closure_tree"
gem "hotwire-rails"
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem "rubocop"
gem "rubocop-discourse"
gem "rubocop-performance"
gem "rubocop-rails"
gem "acts_as_votable"
gem "turbo-rails"
gem "redis", "~> 4.0"
gem "stimulus-rails"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "image_processing", "1.9.3"
gem "mini_magick", "4.9.5"
gem "rails", "~> 6.1.4"
# Use mysql2 as the database for Active Record
gem "active_storage_validations", "0.8.9"
gem "bcrypt", "3.1.13"
gem "bootstrap-sass", "3.4.1"
# Use Puma as the app server
gem "puma", "~> 4.1"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 5.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "jquery-rails"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", " 2.10.0"
# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "bootstrap-will_paginate", "~> 1.0"
gem "faker", "2.11.0"
gem "will_paginate", "3.3.0"
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem "rails-controller-testing"
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i(mri mingw x64_mingw)

  gem "mysql2"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "listen", "~> 3.2"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

group :production do
  gem "aws-sdk-s3", "1.46.0", require: false
  gem "pg"
  # gem 'rails_12factor'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)

gem "importmap-rails", "~> 1.1"
