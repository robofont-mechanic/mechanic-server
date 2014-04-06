require 'sinatra'
require 'builder'

module MechanicServer
  class Docs < Sinatra::Base
    
    get '/' do
      @extensions = Extension.order('created_at DESC')
      erb :index
    end
    
    get '/rss' do
      @extensions = Extension.order('created_at DESC').limit(30)
      builder :rss
    end
  end
end