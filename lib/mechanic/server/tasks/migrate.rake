namespace :db do
  desc "Migrate the database"
  task :migrate do
    require 'logger'
    require './config/boot'

    current_directory = File.dirname __FILE__
    migrations_path = File.join current_directory, '..', 'migrations'

    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate migrations_path
  end
end
