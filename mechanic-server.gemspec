$:.push File.expand_path('../lib', __FILE__)

require 'mechanic/server/version'

Gem::Specification.new do |s|
  s.name        = 'mechanic-server'
  s.version     = Mechanic::Server::VERSION
  s.authors     = ['Jack Jennings']
  s.email       = ['j@ckjennin.gs']
  s.homepage    = 'http://github.com/jackjennings/mechanic-server'
  s.summary     = 'API for recording existant RoboFont extensions'
  s.description = s.summary
  s.license     = 'MIT'

  s.files = Dir['lib/**/*', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'grape', '~> 0.6'
  s.add_dependency 'sinatra'
  s.add_dependency 'rack', '~> 1.5'
  s.add_dependency 'activerecord', '~> 4.2.7.1'
  s.add_dependency 'octokit', '~> 2.0'
  s.add_dependency 'plist'
  s.add_dependency 'rack-permissive_cors'

  # Specified only for security vulnerability
  s.add_dependency 'rack-protection', '~> 1.5.5'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-minitest'
end
