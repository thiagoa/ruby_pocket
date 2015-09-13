require 'test_helper'
require 'support/favorite_factory'
require 'ruby_pocket/favorite'

module RubyPocket
  module Cli
    class ListTest < DatabaseTestCase
      include FavoriteFactory

      def test_lists_available_favorites_with_id_name_and_tags
        values = build_values(tag_names: %w(ruby))
        favorite = create_favorite(values)
        tags = Regexp.union(*favorite.tags.map(&:name))

        output = %x(RUBY_POCKET_ENV=TEST bin/pocket -l)

        assert_match %r(#{favorite.id}.+#{favorite.name}.+#{tags}), output
      end

      def test_shows_message_when_has_no_favorites
        output = %x(RUBY_POCKET_ENV=TEST bin/pocket -l)

        assert_match %r(is empty), output
      end
    end
  end
end
