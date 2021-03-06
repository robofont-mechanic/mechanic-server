require 'rack'

require 'mechanic/server/api'
require 'mechanic/server/documentation'

module Mechanic
  module Server
    class Omnibus < Rack::Cascade

      APPS = [
        Mechanic::API::Server,
        Mechanic::Documentation::Server
      ]

      def initialize(apps = APPS, *args)
        super
      end

    end
  end
end
