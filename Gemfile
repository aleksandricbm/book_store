source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-sass'
gem 'cancancan'
gem 'coffee-rails', '~> 4.2'
gem 'country_select'
gem 'ckeditor'
gem 'devise'
gem 'draper'
gem 'haml'
gem 'kaminari'
gem 'omniauth-facebook'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.2'
gem 'rails_admin'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'wicked'

group :development, :test do
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'brakeman', require: false
  gem 'fasterer'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'overcommit'
  gem 'rails_best_practices'
  gem 'reek'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '~> 2.14'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end
