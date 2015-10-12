require 'grape'

require 'mechanic/server/middleware/permissive_cors'
require 'mechanic/server/api/v1'

module Mechanic
  module API
    class Server < Grape::API
      use Middleware::PermissiveCors

      prefix 'api'

      mount Mechanic::API::V1
    end
  end
end
