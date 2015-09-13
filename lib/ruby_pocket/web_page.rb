module RubyPocket
  HttpError = Class.new RubyPocketError

  class WebPage
    class << self
      alias :for :new
    end

    def initialize(url, scrapper = nil)
      fetch_page url, scrapper
    end

    def title
      @page.title
    end

    private

    def fetch_page(url, scrapper)
      @page = (scrapper || default_scrapper).get(url)
    rescue SocketError => e
      raise HttpError, 'Invalid web address'
    rescue Mechanize::ResponseCodeError => e
      raise HttpError, "#{e.response_code} response code"
    end

    def default_scrapper
      Mechanize.new
    end
  end
end
