require 'ruby_pocket'
RubyPocket.environment = 'TEST'

require_relative '../config/config'
require_relative 'support/custom_assertions'

DatabaseCleaner.strategy = :transaction

class DefaultTestCase < MiniTest::Test
  include CustomAssertions

  alias :assert_not :refute
end

class DatabaseTestCase < DefaultTestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
