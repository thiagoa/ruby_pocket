require 'test_helper'
require 'ruby_pocket/web_page'

module RubyPocket
  class WebPageTest < DefaultTestCase
    def test_calls_the_scrapper_with_the_url
      url = 'http://www.rubytapas.com'
      scrapper = scrapper_mock(url)
      WebPage.for(url, scrapper)

      assert scrapper.verify
    end

    def test_fetches_the_title_from_the_web_page
      url = 'http://www.rubytapas.com'
      scrapper = scrapper_mock(url, 'Ruby Tapas')
      web_page = WebPage.for(url, scrapper)

      assert_equal 'Ruby Tapas', web_page.title
    end

    private

    def scrapper_mock(url, title = nil)
      title ||= 'Ruby Tapas'

      page = OpenStruct.new(title: title)

      scrapper = Minitest::Mock.new
      scrapper.expect :get, page, [url]
      scrapper
    end
  end
end
