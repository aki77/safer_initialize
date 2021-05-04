require "bundler/setup"
require "rails/all"
require "safer_initialize"

class DummyRecord < ActiveRecord::Base; end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'test.sqlite3')

    ActiveRecord::Migration.create_table :dummy_records, if_not_exists: true do |t|
      t.timestamps
    end
  end

  config.after(:suite) do
    ActiveRecord::Migration.drop_table :dummy_records
  end
end
