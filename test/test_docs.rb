require 'spec_helper'

require 'mechanic/server/docs'

module Mechanic
  class TestDocs < Minitest::Test
    include Rack::Test::Methods

    def app
      Docs
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
