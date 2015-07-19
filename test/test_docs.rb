require 'spec_helper'

require './mechanic/docs'

class TestMechanicDocs < Minitest::Test
  include Rack::Test::Methods

  def app
    Mechanic::Docs
  end

  def test_index
    get '/'
    assert last_response.ok?
  end

  def test_rss_feed
    get '/rss'
    assert last_response.ok?
  end

end
