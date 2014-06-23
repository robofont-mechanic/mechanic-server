require 'active_record'
require 'octokit'
require 'hey'

require File.expand_path('../environment', __FILE__)

models = File.join(File.dirname(__FILE__), '..', 'models')
$LOAD_PATH << File.expand_path(models)

# Constent Missing for requiring models files
def Object.const_missing(const)
  require const.to_s.underscore
  klass = const_get(const)
  return klass if klass
end