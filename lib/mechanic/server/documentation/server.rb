require 'sinatra'
require 'tilt/erb'
require 'tilt/builder'

require 'mechanic/server/models/extension'

module Mechanic
  module Documentation
    class Server < Sinatra::Base

      get '/' do
        @extensions = Extension.all.sort_by {|e| e.name.downcase}
        erb :index
      end

      get '/rss' do
        @extensions = Extension.order('created_at DESC').limit(30)
        builder :rss
      end

    end
  end
end
