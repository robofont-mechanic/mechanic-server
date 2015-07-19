require 'rack'
require 'rack/cors'

require './config/boot'

require 'mechanic/server/api'
require 'mechanic/server/docs'

unless ENV['RACK_ENV'] == 'production'
  require 'rack/env'
  use Rack::Env
end

use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post]
  end
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Rack::Cascade.new [
  Mechanic::API,
  Mechanic::Docs
]
