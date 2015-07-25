require './config/boot'

require 'mechanic/server/omnibus'

unless ENV['RACK_ENV'] == 'production'
  require 'rack/env'
  use Rack::Env
end

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Mechanic::Server::Omnibus.new
