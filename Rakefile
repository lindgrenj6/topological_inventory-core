begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'TopologicalInventory'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'

require "rspec/core/rake_task"

require "active_record"

root = File.expand_path(__dir__)
ActiveRecord::Tasks::DatabaseTasks.env = ENV["ENV"] || "development"
ActiveRecord::Tasks::DatabaseTasks.database_configuration = YAML.load(File.read(File.join(root, 'config/database.yml')))
ActiveRecord::Tasks::DatabaseTasks.db_dir = File.join(root, "db")
ActiveRecord::Tasks::DatabaseTasks.migrations_paths = [File.join(root, "db/migrate")]
ActiveRecord::Tasks::DatabaseTasks.root = root
ActiveRecord::Base.configurations = ActiveRecord::Tasks::DatabaseTasks.database_configuration

# DB related rake tasks
namespace :db do
  desc "Creates the database from DATABASE_URL or config/database.yml for the current RAILS_ENV"
  task :create do
    ActiveRecord::Tasks::DatabaseTasks.create_current
  end

  desc "Drops the database from DATABASE_URL or config/database.yml for the current RAILS_ENV"
  task :drop do
    ActiveRecord::Tasks::DatabaseTasks.drop_current
  end

  desc "Migrates the database"
  task :migrate do
    ActiveRecord::Tasks::DatabaseTasks.migrate
  end
end

# Spec related rake tasks
RSpec::Core::RakeTask.new(:spec)

namespace :spec do
  task :initialize do
    ActiveRecord::Tasks::DatabaseTasks.env = "test"
  end

  desc "Setup the database for running tests"
  task :setup => ["initialize", "db:create"]
end

task default: :spec
