require 'uri'
require 'active_record'
require 'yaml'
require 'erb'
require 'hey'

if ENV['DATABASE_URL']
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
else # local environment
  environment = ENV['RACK_ENV'] || 'development'
  db = YAML.load(File.read('config/database.yml'))[environment]
  ActiveRecord::Base.establish_connection(db)
end

ActiveRecord::Base.include_root_in_json = false

Hey.api_token = ENV['YO_API_KEY']
