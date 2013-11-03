source "https://rubygems.org"

# Declare your gem's dependencies in bookings.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
gem 'coffee-rails'
gem 'active_model_serializers'
gem 'devise'


group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'factory_girl_rails'

  gem 'guard-minitest'
  gem 'guard-rspec'
  
  gem 'spork', :github => 'sporkrb/spork'
	gem 'spork-rails', :github => 'sporkrb/spork-rails'
  gem 'guard-spork'
  	
  gem 'guard-livereload'

  gem 'launchy'
  gem 'rb-fsevent'
  gem 'rb-inotify', :require => false
end