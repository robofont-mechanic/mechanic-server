$:.push File.expand_path('../lib', __FILE__)

require 'rake/testtask'
require 'mechanic/server/tasks'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test*.rb']
  t.verbose = true
end

task default: [:test]
