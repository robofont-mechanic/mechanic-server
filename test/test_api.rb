require 'spec_helper'

require 'mechanic/server/api'

module Mechanic
  class TestAPI < Minitest::Test
    include Rack::Test::Methods

    def app
      API
    end

    def test_gets_repos
      get '/api/v1/registry.json'
      assert last_response.ok?
      assert JSON.parse(last_response.body).is_a? Array
    end

    def test_has_cors_headers
      header 'Origin', '192.0.0.1'
      get '/api/v1/registry.json'
      assert_equal '192.0.0.1', last_response.headers['Access-Control-Allow-Origin']
    end

  end
end
