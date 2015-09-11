require 'test_helper'
require 'minitest/mock'
require 'ruby_pocket/favorite_creator'

module RubyPocket
  class FavoriteCreatorTest < DatabaseTestCase
    def test_does_not_inject_a_persisted_favorite
      persisted_favorite = Favorite.create url: 'http://www.rubytapas.com'
      creator = build_favorite_creator({})

      error = assert_raises StandardError do
        creator.favorite = persisted_favorite
      end

      assert_match(/new favorite/, error.message)
    end

    def test_when_no_name_present_in_values_fetches_web_page_from_url
      url = 'http://www.rubytapas.com'

      values = { name: nil, url: url }
      favorite = Favorite.new
      web_page = web_page_mock(url, page_title: 'Ruby Tapas')

      creator = build_favorite_creator(values, favorite, web_page)
      creator.save

      assert web_page.verify
    end

    def test_when_no_name_present_in_values_fetches_name_from_web_pages_title
      url = 'http://www.rubytapas.com'

      values = { name: nil, url: url }
      favorite = Favorite.new
      web_page = web_page_mock(url, page_title: 'Ruby Tapas')

      creator = build_favorite_creator(values, favorite, web_page)
      creator.save

      assert_equal 'Ruby Tapas', favorite.name
    end

    def test_does_not_save_favorite_when_values_are_invalid
      favorite = Favorite.new
      creator = build_favorite_creator({}, favorite)

      assert_not creator.save
      assert favorite.new?
    end

    def test_has_errors_when_values_are_invalid
      creator = build_favorite_creator({})
      creator.save

      assert_not_empty creator.errors[:url]
      assert_match(/not present/, creator.errors[:url].first)
    end

    def test_saves_favorite_when_values_are_valid
      favorite = Favorite.new
      params = { name: 'RubyTapas', url: 'http://www.rubytapas.com' }
      creator = build_favorite_creator(params, favorite)

      assert creator.save
      assert_not favorite.new?
    end

    private

    def build_favorite_creator(values, favorite = nil, web_page = nil)
      FavoriteCreator.new(values).tap do |creator|
        creator.favorite = favorite if favorite
        creator.web_page = web_page if web_page
      end
    end

    def web_page_mock(url, page_title: 'Ruby Tapas')
      contents = OpenStruct.new(title: page_title)

      web_page_class = Minitest::Mock.new
      web_page_class.expect :for, contents, [url]
    end
  end
end
