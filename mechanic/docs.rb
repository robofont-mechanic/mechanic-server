require 'sinatra'
require 'builder'

module Mechanic
  class Docs < Sinatra::Base
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
