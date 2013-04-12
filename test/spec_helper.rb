ENV['RACK_ENV'] = 'test'
require './mechanic-server'
require 'minitest/autorun'
require 'rack/test'