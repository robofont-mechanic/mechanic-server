require 'uri'
require 'yaml'

# Sets up database configuration
db = URI.parse(ENV['DATABASE_URL'] || 'http://localhost')
if db.scheme == 'postgres' # Heroku environment
  # ActiveRecord::Base.establish_connection(
  #   :adapter  => db.scheme == 'postgres' ? 'em_postgresql' : db.scheme,
  #   :host     => db.host,
  #   :username => db.user,
  #   :password => db.password,
  #   :database => db.path[1..-1],
  #   :encoding => 'utf8'
  # )
else # local environment
  environment = ENV['RACK_ENV']
  db = YAML.load(File.read('config/database.yml'))[environment]
  ActiveRecord::Base.establish_connection(db)
end