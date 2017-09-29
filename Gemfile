source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-sass', '~> 3.3'
gem 'cancancan', '~> 2.0'
gem 'carrierwave', '~> 0.11.2'
gem 'carrierwave-google-storage', '~> 0.7.0'
gem 'ckeditor', '~> 4.2.4'
gem 'coffee-rails', '~> 4.2'
gem 'country_select', '~> 3.1'
gem 'devise', '~> 4.3'
gem 'dotenv-rails', '~> 2.2.1'
gem 'draper', '~> 3.0.0'
gem 'ffaker', '~>2.6.0'
gem 'fog', '~> 1.38.0'
gem 'google-cloud', '~> 0.22.0'
gem 'haml', '~> 5.0.1'
gem 'jbuilder', '~> 2.5'
gem 'kaminari', '~> 1.0.1'
gem 'mime-types', '>= 1.16', '< 4'
gem 'mini_magick', '~> 4.8.0'
gem 'omniauth-facebook', '~> 4.0.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.2'
gem 'rails_admin', '~> 1.2.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'wicked', '~> 1.3.2'

group :development, :test do
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'pry-byebug', '~> 3.4.2'
  gem 'rspec-rails', '~> 3.6.0'
end

group :development do
  gem 'brakeman', '~> 3.7.0'
  gem 'fasterer', '~> 0.3.2'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'overcommit', '~> 0.40.0'
  gem 'rails_best_practices', '~> 1.18.1'
  gem 'reek', '~> 4.7.1'
  gem 'rubocop', '~> 0.49.1'
  gem 'spring', '~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '~> 2.14.4'
  gem 'capybara-webkit', '= 1.1.0'
  gem 'database_cleaner', '~> 1.6.1'
  gem 'rails-controller-testing', '~> 1.0.2'
  gem 'shoulda-matchers', '~> 3.1.2'
end
