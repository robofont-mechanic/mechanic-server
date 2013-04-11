require './mechanic-server'
require 'minitest/autorun'
require 'rack/test'

class TestMechanistServer < MiniTest::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    MechanicServer::API
  end
  
  def test_gets_repos
    get '/v1/registry.json'
    assert last_response.ok?
    assert_equal JSON.parse(last_response.body), []
  end
end