require 'test_helper'
require 'support/favorite_factory'
require 'ruby_pocket/favorite'

module RubyPocket
  module Cli
    class DeleteTest < FeatureTestCase
      include FavoriteFactory

      def test_deletes_one_favorite_by_id
        favorite = create_favorite

        output = run_command("pocket -d #{favorite.id}")

        assert_match %r(#{favorite.name}.+deleted), output.stdout
        assert_raises(Sequel::Error) { favorite.reload }
      end

      def test_deletes_two_favorites_by_id
        favorite_one = create_favorite
        favorite_two = create_favorite(
          name: 'Ruby',
          url: 'http://www.ruby-lang.org'
        )

        output = run_command("pocket -d #{favorite_one.id},#{favorite_two.id}")

        assert_match %r(#{favorite_one.name}.+deleted), output.stdout
        assert_match %r(#{favorite_two.name}.+deleted), output.stdout
        assert_raises(Sequel::Error) { favorite_one.reload }
        assert_raises(Sequel::Error) { favorite_two.reload }
      end

      def test_does_not_delete_favorite_when_not_found
        favorite = create_favorite

        output = run_command("pocket -d #{favorite.id},1000")

        assert_match %r(#{favorite.name}.+deleted), output.stdout
        assert_match %r(1000 not found), output.stdout
        assert_raises(Sequel::Error) { favorite.reload }
      end
    end
  end
end
