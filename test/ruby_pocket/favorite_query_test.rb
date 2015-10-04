require 'test_helper'
require 'support/favorite_factory'
require 'ruby_pocket/favorite_query'

module RubyPocket
  class FavoriteQueryTest < DatabaseTestCase
    include FavoriteFactory

    def test_finds_all_favorites
      ruby_flow = create_favorite(url: 'http://www.rubyflow.com')
      ruby_tapas = create_favorite(url: 'http://www.rubytapas.com')

      favorites = FavoriteQuery.new.all

      assert_equal [ruby_flow, ruby_tapas], favorites
    end

    def test_when_no_tag_names_finds_all_favorites
      ruby_flow = create_favorite(url: 'http://www.rubyflow.com')
      ruby_tapas = create_favorite(url: 'http://www.rubytapas.com')

      favorites = FavoriteQuery.new.where(tag_names: nil).all

      assert_equal [ruby_flow, ruby_tapas], favorites
    end

    def test_finds_favorite_by_tag_name
      create_favorite(
        url: 'http://www.rubyflow.com',
        tag_names: %w(ruby)
      )
      microservices = create_favorite(
        url: 'http://martinfowler.com/microservices',
        tag_names: %w(microservices)
      )

      favorites = FavoriteQuery
        .new
        .where(tag_names: %w[microservices])
        .all

      assert_equal [microservices], favorites
    end

    def test_finds_favorite_by_more_than_one_tag_name
      create_favorite(
        url: 'http://www.rubyflow.com',
        tag_names: %w(ruby)
      )
      create_favorite(
        url: 'http://railscasts.com',
        tag_names: %w(screencasts)
      )
      ruby_tapas = create_favorite(
        url: 'http://www.rubytapas.com',
        tag_names: %w(ruby screencasts)
      )

      favorites = FavoriteQuery
        .new
        .where(tag_names: %w[ruby screencasts])
        .all

      assert_equal [ruby_tapas], favorites
    end

    def test_finds_favorite_by_more_than_one_tag_name_with_chained_syntax
      create_favorite(
        url: 'http://www.rubyflow.com',
        tag_names: %w(ruby)
      )
      create_favorite(
        url: 'http://railscasts.com',
        tag_names: %w(screencasts)
      )
      ruby_tapas = create_favorite(
        url: 'http://www.rubytapas.com',
        tag_names: %w(ruby screencasts)
      )

      favorites = FavoriteQuery
        .new
        .where(tag_names: %w[ruby])
        .where(tag_names: %w[screencasts])
        .all

      assert_equal [ruby_tapas], favorites
    end

    def test_fails_when_tag_name_does_not_exist
      error = assert_raises ArgumentError do
        FavoriteQuery.new.where(tag_names: %w[microservices]).all
      end

      assert_match %r(not found), error.message
    end

    def test_finds_favorites_by_partial_tag_matching
      rubinius = create_favorite(
        url: 'http://rubini.us',
        tag_names: %w(rubinius)
      )
      ruby_tapas = create_favorite(
        url: 'http://www.rubytapas.com',
        tag_names: %w(ruby screencasts)
      )
      create_favorite(
        url: 'http://railscasts.com',
        tag_names: %w(screencasts)
      )

      favorites = FavoriteQuery
        .new
        .where(tag_names: %w[/rub/])
        .all

      assert_equal [rubinius, ruby_tapas], favorites
    end

    def test_finds_everything_when_using_empty_partial_match_string
      railscasts = create_favorite(
        url: 'http://railscasts.com',
        tag_names: %w(/railscasts/)
      )

      favorites = FavoriteQuery
        .new
        .where(tag_names: %w[//])
        .all

      assert_equal [railscasts], favorites
    end

    def test_does_not_fail_when_cant_find_tags_by_partial_matching
      favorites = FavoriteQuery
        .new
        .where(tag_names: %w[/rub/])
        .all

      assert_empty favorites
    end

    def test_has_results_when_combining_partial_with_exact_tag_matching
      create_favorite(
        url: 'http://existingfavorite.com',
        tag_names: %w(rubinius)
      )
      ruby_tapas = create_favorite(
        url: 'http://www.rubytapas.com',
        tag_names: %w(ruby screencasts)
      )

      favorites = FavoriteQuery
        .new
        .where(tag_names: %w[screencasts /rub/])
        .all

      assert_equal [ruby_tapas], favorites
    end

    def test_does_not_have_results_when_combining_partial_with_exact_tag_matching
      create_favorite(
        url: 'http://existingfavorite.com',
        tag_names: %w(existing)
      )

      favorites = FavoriteQuery
        .new
        .where(tag_names: %w[existing /rub/])
        .all

      assert_empty favorites
    end
  end
end
