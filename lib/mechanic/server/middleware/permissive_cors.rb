require 'rack/cors'

module Mechanic
  module Middleware
    class PermissiveCors < Rack::Cors

      def initialize(*args)
        super(*args) do
          allow_all
        end
      end

      private

      def allow_all
        allow do
          origins '*'
          resource '*', headers: :any, methods: [:get, :post]
        end
      end

    end
  end
end
