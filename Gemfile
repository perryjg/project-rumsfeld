source 'http://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.3'
gem 'bootstrap-sass'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'RedCloth'
gem 'liquid'
gem 'heroku'
gem 'taps'

group :development do
	gem 'sqlite3'
	gem 'annotate', git: 'git://github.com/ctran/annotate_models.git'
end

group :development, :test do
	gem 'rspec-rails'
	gem 'factory_girl_rails'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :test do
	gem 'capybara'
	gem 'faker'
	gem 'database_cleaner'
end

group :production do
	gem 'mysql2'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
