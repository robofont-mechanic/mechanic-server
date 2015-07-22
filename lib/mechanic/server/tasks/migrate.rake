namespace :db do
  desc "Migrate the database"
  task :migrate do
    require 'logger'
    require './config/boot'

    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
