require 'spec_helper'

require 'mechanic/server/documentation'

module Mechanic
  module Documentation
    class TestServer < Minitest::Test
      include Rack::Test::Methods

      def app
        Server
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
end
