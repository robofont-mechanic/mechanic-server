require './config/boot'

require 'mechanic/server'

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Mechanic::Server::Omnibus.new
