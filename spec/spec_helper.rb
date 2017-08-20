require 'bundler/setup'
require 'webmock/rspec'
require 'mobilepay'

RSpec.configure do |config|
    # Enable flags like --only-failures and --next-failure
    config.example_status_persistence_file_path = '.rspec_status'

    config.expect_with :rspec do |c|
        c.syntax = :expect
    end

    config.before :all do
        WebMock.enable!
    end
end
