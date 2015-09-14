require 'support/default_test_case'

class DatabaseTestCase < DefaultTestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
