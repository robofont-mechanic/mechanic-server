ENV['RACK_ENV'] = 'test'
require './config/boot'
require './mechanic/api'
require 'minitest/autorun'
require 'rack/test'

Octokit.connection_options[:ssl] = {:ca_file => './ssl/cert.pem'}