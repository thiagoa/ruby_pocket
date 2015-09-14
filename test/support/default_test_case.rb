require 'support/custom_assertions'

class DefaultTestCase < MiniTest::Test
  include CustomAssertions

  alias :assert_not :refute
  alias :assert_not_empty :refute_empty
  alias :assert_not_match :refute_match
end
