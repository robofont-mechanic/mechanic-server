source 'https://rubygems.org'
gem 'rack', '1.5.2'
gem 'activerecord', '3.2.13'
gem 'grape', '0.4.1'
gem 'rack-cors'
gem 'github_api'
gem 'unicorn'

group :test do
  gem 'minitest'
end

group :development, :test do
  gem 'rack-env'
  gem 'sqlite3'
end

group :production do
	gem 'pg'
end