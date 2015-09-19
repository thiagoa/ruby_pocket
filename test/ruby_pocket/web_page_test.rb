require 'test_helper'
require 'support/webmock'
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

    def test_throws_http_error_when_url_not_found
      url = 'http://google.com/does_not_exist'
      stub_request(:any, url).to_return status: 404

      error = assert_raises(HttpError) do
        WebPage.for url
      end

      assert_match %r(404), error.message
    end

    def test_throws_http_error_when_internal_server_error
      url = 'http://throwmea500.com'
      stub_request(:any, url).to_return status: 500

      error = assert_raises(HttpError) do
        WebPage.for url
      end

      assert_match %r(500), error.message
    end

    def test_throws_http_error_url_does_not_exist
      url = 'http://inexistenturl.com'
      stub_request(:any, url).to_raise SocketError

      error = assert_raises(HttpError) do
        WebPage.for url
      end

      assert_match %r(socket error), error.message
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
