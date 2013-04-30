require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

task :default => [:test]

namespace :db do
  desc "Migrate the database"
  task :migrate do
    require 'logger'
    require './mechanic-server'
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end

desc "Check Rate Limit"
task :ratelimit do
  require './mechanic-server'
  list = Github::Repos.new(user: 'jackjennings', client_id: ENV['GITHUB_ID'], client_secret: ENV['GITHUB_SECRET']).list
  puts ENV['GITHUB_ID']
  puts list.headers.ratelimit_remaining
end