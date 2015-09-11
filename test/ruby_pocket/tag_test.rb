require 'test_helper'
require 'ruby_pocket/tag'

module RubyPocket
  class TagTest < DatabaseTestCase
    def test_tag_name_is_unique
      Tag.create name: 'ruby'

      error = assert_raises Sequel::ValidationFailed do
        Tag.create name: 'ruby'
      end

      assert_match('name is already taken', error.message)
    end
  end
end
