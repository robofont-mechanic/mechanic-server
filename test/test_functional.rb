require 'spec_helper'

class TestMechanistServer < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    MechanicServer::API
  end
  
  def test_gets_repos
    get '/api/v1/registry.json'
    assert last_response.ok?
    assert JSON.parse(last_response.body).is_a? Array
  end
end