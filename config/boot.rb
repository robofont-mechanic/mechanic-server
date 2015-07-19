require 'active_record'
require 'octokit'

require File.expand_path('../environment', __FILE__)

models = File.join(File.dirname(__FILE__), '..', 'mechanic')
$LOAD_PATH << File.expand_path(models)
