source 'https://rubygems.org'
ruby '2.5.3'

gem 'rails', '~> 5.1.7'
gem 'rack-cors', require: 'rack/cors'
gem 'pg'

gem 'spring', group: :development

group :development, :test do
  gem "pry"
  gem "rspec-rails"
  gem "factory_bot", "~> 4.0"
end

group :test do
  gem 'database_rewinder'
end
