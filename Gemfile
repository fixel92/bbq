source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'carrierwave'
gem 'devise'
gem 'devise-i18n'
gem 'figaro'
gem 'fog-aws'
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 4.1'
gem 'pundit'
gem 'rails', '~> 6.0.1'
gem 'rails-i18n', '~> 6.0.0'
gem 'resque'
gem 'rmagick'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'pry'
  gem 'rspec-rails'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'capistrano-resque', '~> 0.2.3', require: false
  gem 'letter_opener'

  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
