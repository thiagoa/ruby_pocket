require 'ruby_pocket'
RubyPocket.environment = 'TEST'

require_relative '../config/config'
require_relative 'support/custom_assertions'

DatabaseCleaner.strategy = :truncation

class DefaultTestCase < MiniTest::Test
  include CustomAssertions

  alias :assert_not :refute
  alias :assert_not_empty :refute_empty
end

class DatabaseTestCase < DefaultTestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
