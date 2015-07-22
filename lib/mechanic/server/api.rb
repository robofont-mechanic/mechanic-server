require 'grape'
require 'rack/cors'

require 'mechanic/server/models/extension'

module Mechanic
  class API < Grape::API
    prefix 'api'
    version 'v1', using: :path
    format :json

    use Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post]
      end
    end

    namespace :registry do
      get do
        Extension.all
      end

      params do
        requires :name, type: String, regexp: /.+/
        requires :filename, type: String, regexp: /.+/
        requires :repository, type: String, regexp: /.+/
      end
      post do
        extension = Extension.create({
          name: params[:name],
          filename: params[:filename],
          repository: params[:repository]
        })
        error!({error: extension.errors.full_messages}, 400) unless extension.valid?
      end
    end
  end
end
