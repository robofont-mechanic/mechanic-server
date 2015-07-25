require './config/boot'

require 'mechanic/server/omnibus'

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Mechanic::Server::Omnibus.new
