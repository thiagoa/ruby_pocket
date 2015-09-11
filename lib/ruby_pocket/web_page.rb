module RubyPocket
  class WebPage
    class << self
      alias :for :new
    end

    def initialize(url, scrapper = nil)
      @page = (scrapper || default_scrapper).get(url)
    end

    def title
      @page.title
    end

    private

    def default_scrapper
      Mechanize.new
    end
  end
end
