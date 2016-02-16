require 'grape'

require 'mechanic/server/api/v1'
require 'rack/permissive_cors'

module Mechanic
  module API
    class Server < Grape::API
      use Rack::PermissiveCors

      prefix 'api'

      mount Mechanic::API::V1
    end
  end
end
