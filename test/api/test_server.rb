require 'spec_helper'

require 'mechanic/server/api'

module Mechanic
  module API
    class TestAPI < Minitest::Test
      include Rack::Test::Methods

      def app
        Server
      end

      def test_gets_repos
        get '/api/v1/registry.json'
        assert last_response.ok?
        assert_kind_of Array, JSON.parse(last_response.body)
      end

      def test_has_cors_headers
        header 'Origin', '192.0.0.1'
        get '/api/v1/registry.json'
        assert_equal '192.0.0.1', last_response.headers['Access-Control-Allow-Origin']
      end

    end
  end
end
