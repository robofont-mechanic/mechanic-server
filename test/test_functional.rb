require 'spec_helper'

class TestMechanicAPI < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Mechanic::API
  end

  def test_gets_repos
    get '/api/v1/registry.json'
    assert last_response.ok?
    assert JSON.parse(last_response.body).is_a? Array
  end
end
