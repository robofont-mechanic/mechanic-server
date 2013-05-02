require 'sinatra'

module MechanicServer
  class Docs < Sinatra::Base
    get '/rss' do
      @extensions = Extension.order('created_at DESC').limit(30).all
      builder :rss
    end
  end
end