require 'ruby_pocket'
RubyPocket.environment = 'TEST'

require_relative '../config/config'
require_relative 'support/custom_assertions'
require_relative 'support/feature_assertions'

DatabaseCleaner.strategy = :truncation

class DefaultTestCase < MiniTest::Test
  include CustomAssertions

  alias :assert_not :refute
  alias :assert_not_empty :refute_empty
  alias :assert_not_match :refute_match
end

class DatabaseTestCase < DefaultTestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

class FeatureTestCase < DatabaseTestCase
  include FeatureAssertions

  private

  def run_command(command)
    %x(RUBY_POCKET_ENV=TEST bin/#{command})
  end
end
