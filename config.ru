require './mechanic-server'
require 'rack'
require 'rack/contrib/try_static'

# use Rack::TryStatic,
#   :root => 'public',
#   :urls => %w[/],
#   :try => ['index.html', '/index.html']
	
use ActiveRecord::ConnectionAdapters::ConnectionManagement

run MechanicServer::API
