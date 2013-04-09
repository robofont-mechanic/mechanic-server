require 'rubygems'
require 'grape'
require 'active_record'
require './config/boot'

module MechanicServer
  class API < Grape::API
    version 'v1', using: :path
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