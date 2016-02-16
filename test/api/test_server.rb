require 'spec_helper'

require 'mechanic/server/api'

module Mechanic
  module API
    class TestAPI < Minitest::Test
      include Rack::Test::Methods

      def teardown
        Extension.destroy_all
      end

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

      def test_creates_an_extension
        post '/api/v1/registry', filename: 'Dummy.roboFontExt', repository: 'jackjennings/Dummy', name: 'Dummy'
        assert last_response.created?, "Expected 201, but got #{last_response.status}: \n\n\t#{last_response.inspect}"
      end

    end
  end
end
