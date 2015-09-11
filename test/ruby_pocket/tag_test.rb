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

    def test_trims_white_space_from_tag_name
      tag = Tag.create name: ' Ruby  '

      assert_equal 'ruby', tag.name
    end

    def test_downcases_tag_name
      tag = Tag.create name: 'Ruby'

      assert_equal 'ruby', tag.name
    end

    def test_puts_dashes_between_words_on_tag_name
      tag = Tag.create name: 'Precious Ruby'

      assert_equal 'precious-ruby', tag.name
    end

    def test_replaces_non_letter_characters_with_dashes_on_tag_name
      names = ['Precious_Ruby', 'Cool_!#>Precious%$#%%Ruby']
      tags = names.map { |name| Tag.create(name: name) }

      assert_equal %w(precious-ruby cool-precious-ruby), tags.map(&:name)
    end

    def test_normalizes_dashes_of_the_tag_name
      tag = Tag.create name: 'Precious__Ruby'

      assert_equal 'precious-ruby', tag.name
    end

    def test_normalizes_spaces_between_words_of_tag_name
      tag = Tag.create name: 'Cool  Precious  Ruby'

      assert_equal 'cool-precious-ruby', tag.name
    end
  end
end
