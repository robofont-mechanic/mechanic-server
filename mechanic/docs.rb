require 'sinatra'
require 'builder'

module MechanicServer
  class Docs < Sinatra::Base
    
    get '/' do
      @extensions = Extension.order('created_at DESC').all
      erb :index
    end
    
    get '/rss' do
      @extensions = Extension.order('created_at DESC').limit(30).all
      builder :rss
    end
  end
end