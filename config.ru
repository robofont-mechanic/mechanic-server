require './config/boot'

require 'mechanic/server/api'
require 'mechanic/server/documentation'

unless ENV['RACK_ENV'] == 'production'
  require 'rack/env'
  use Rack::Env
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Rack::Cascade.new [
  Mechanic::API,
  Mechanic::Documentation
]
