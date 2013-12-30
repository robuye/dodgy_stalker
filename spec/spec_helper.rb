require 'bundler/setup'
require 'database_cleaner'
require 'dodgy_stalker'

DatabaseCleaner.strategy = :transaction
RSpec.configure do |config|
  config.mock_with :rspec
  config.order = "random"
  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }

  config.around do |example|
    DatabaseCleaner.start
    example.run
    DatabaseCleaner.clean
  end
end

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'dodgy_stalker',
  username: 'rob',
  host: 'localhost'
)


ActiveRecord::Migrator.migrate(File.expand_path('../migrations', __FILE__))
