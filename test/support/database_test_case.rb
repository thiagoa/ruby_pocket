require 'support/default_test_case'

class DatabaseTestCase < DefaultTestCase
  def setup
    DatabaseCleaner[:sequel].start
  end

  def teardown
    DatabaseCleaner[:sequel].clean
  end
end
