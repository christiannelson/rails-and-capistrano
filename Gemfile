source 'https://rubygems.org'

ruby '2.1.5'

gem 'unicorn'
gem 'rack-canonical-host'
gem 'rails', '~> 4.1.5'
gem 'pg'

gem 'slim-rails'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'coffee-rails'
gem 'turbolinks'
gem 'simple_form', '~> 3.1.0.rc2'                      # Bootstrap 3 support
gem 'uglifier'

gem 'awesome_print'

gem 'capistrano', '~> 3.1'
gem 'capistrano-rails', '~> 1.1'

group :production, :staging do
  gem 'rails_stdout_logging'
end

group :test do
  gem 'fuubar'
  gem 'capybara'
  gem 'poltergeist'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'simplecov'
end

group :test, :development do
  gem 'rspec-rails'
  #gem 'cane'
  #gem 'morecane'
end

group :development do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'foreman'
  gem 'launchy'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'guard', '~> 2'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'rb-fsevent'
  gem 'growl'
end
