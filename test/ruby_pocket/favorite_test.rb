require 'test_helper'
require 'ruby_pocket/favorite'

module RubyPocket
  class FavoriteTest < DatabaseTestCase
    def test_persists_a_favorite
      favorite = Favorite.create(build_values)

      assert_not favorite.new?
    end

    def test_url_is_unique
      Favorite.create(build_values)

      error = assert_raises Sequel::ValidationFailed do
        Favorite.create(build_values)
      end

      assert_match(/url is already taken/, error.message)
    end

    def test_name_is_trimmed
      values = build_values name: '  Ruby is Cool '
      favorite = Favorite.create values

      assert_equal 'Ruby is Cool', favorite.name
    end

    def test_favorite_is_persisted_correctly
      values = build_values
      favorite = Favorite.create values

      assert_subset values, favorite.values
    end

    def test_persists_a_favorite_with_tags
      values = build_values tag_names: %w(ruby cool)
      favorite = Favorite.create values

      assert_not favorite.new?
      assert_equal %w(ruby cool), favorite.tags.map(&:name)
    end

    def test_persists_a_favorite_without_tags
      favorite = Favorite.create build_values

      assert_empty favorite.tags
    end

    def test_tags_with_equal_names_are_not_duplicated
      ruby_flow_values = build_values(
        url: 'http://www.rubyflow.com',
        tag_names: %w(Ruby)
      )
      ruby_flow = Favorite.create ruby_flow_values

      ruby_tapas_values = build_values(
        url: 'http://www.rubytapas.com',
        tag_names: %w(ruby)
      )
      ruby_tapas = Favorite.create ruby_tapas_values

      assert_equal ruby_flow.tags, ruby_tapas.tags
    end

    private

    def build_values(values = {})
      {
        name: 'Ruby Flow',
        url: 'http:///www.rubyflow.com'
      }.merge(values)
    end
  end
end
