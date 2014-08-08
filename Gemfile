source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'puma', '~> 2.8.2'
gem 'grape', '~> 0.7.0'
gem 'grape-entity'
gem 'haml'
gem 'multi_json'
gem 'foreman', '~> 0.6'
gem 'sinatra-asset-pipeline'
gem 'grape-swagger'
gem 'haml_coffee_assets'
gem 'execjs'

group :development do
  gem 'letter_opener'
  gem 'mina'
  gem 'sprockets', '~> 2.12.1'
end

group :development, :test do
  gem 'factory_girl'
  gem 'database_cleaner'
end

group :test do
  gem 'simplecov', require: false
  gem 'rspec', '~> 3'
end

group :production do
  gem 'rack'
  gem 'therubyracer'
end