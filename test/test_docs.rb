require 'spec_helper'

require 'mechanic/server/documentation'

module Mechanic
  class TestDocumentation < Minitest::Test
    include Rack::Test::Methods

    def app
      Documentation
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
end
