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

  end
end
