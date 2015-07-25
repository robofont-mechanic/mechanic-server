require 'rack/cascade'

require 'mechanic/server/api'
require 'mechanic/server/documentation'

module Mechanic
  module Server
    class Omnibus < Rack::Cascade

      APPS = [
        Mechanic::API,
        Mechanic::Documentation
      ]

      def initialize(apps = APPS, *args)
        super
      end

    end
  end
end
