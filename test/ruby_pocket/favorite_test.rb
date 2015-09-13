require 'test_helper'
require 'support/favorite_factory'
require 'ruby_pocket/favorite'

module RubyPocket
  class FavoriteTest < DatabaseTestCase
    include FavoriteFactory

    def test_persists_a_favorite
      favorite = create_favorite

      assert_not favorite.new?
    end

    def test_url_is_unique
      create_favorite

      error = assert_raises(Sequel::ValidationFailed) do
        create_favorite
      end

      assert_match(/url is already taken/, error.message)
    end

    def test_name_is_trimmed
      values = build_values(name: '  Ruby is Cool ')
      favorite = create_favorite(values)

      assert_equal 'Ruby is Cool', favorite.name
    end

    def test_favorite_is_persisted_correctly
      values = build_values
      favorite = create_favorite

      assert_subset values, favorite.values
    end

    def test_persists_a_favorite_with_tags
      values = build_values(tag_names: %w(ruby cool))
      favorite = create_favorite(values)

      assert_not favorite.new?
      assert_equal %w(ruby cool), favorite.tags.map(&:name)
    end

    def test_persists_a_favorite_without_tags
      favorite = create_favorite

      assert_empty favorite.tags
    end

    def test_tags_with_equal_names_are_not_duplicated
      ruby_flow_values = build_values(
        url: 'http://www.rubyflow.com',
        tag_names: %w(Ruby)
      )
      ruby_flow = create_favorite(ruby_flow_values)

      ruby_tapas_values = build_values(
        url: 'http://www.rubytapas.com',
        tag_names: %w(ruby)
      )
      ruby_tapas = create_favorite(ruby_tapas_values)

      assert_equal ruby_flow.tags, ruby_tapas.tags
    end

    def test_favorites_with_tags_are_deleted_without_errors
      values = build_values(tag_names: %w(one two))
      favorite = create_favorite(values)

      assert favorite.destroy
    end
  end
end
