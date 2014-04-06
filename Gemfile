source 'https://rubygems.org'
ruby '2.1.1'

gem 'rack', '1.5.2'
gem 'activerecord', '4.0.2'
gem 'grape', '0.6.1'
gem 'rack-cors'
gem 'octokit', '~> 2.0'
gem 'unicorn'
gem 'sinatra'
gem 'builder'

group :test do
  gem 'minitest'
  gem 'rack-test'
end

group :development, :test do
  gem 'rack-env'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end
