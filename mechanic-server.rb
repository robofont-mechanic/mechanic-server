require 'rubygems'
require 'grape'
require 'active_record'
require 'github_api'
require './config/boot'
require 'rack/cors'

module MechanicServer
  class API < Grape::API
    version 'v1', using: :path
    use Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post]
      end
    end
    format :json
    
    namespace :registry do
      get do
        Extension.all
      end
      
      params do
        requires :name, type: String
        requires :filename, type: String
        requires :repository, type: String
      end
      post do
        Extension.create!({
          name: params[:name],
          filename: params[:filename],
          repository: params[:repository]
        })
      end
    end
  end
end