require 'ruby_pocket/favorite'

module RubyPocket
  class FavoriteCreator
    attr_accessor :web_page

    def initialize(params)
      @params = params
    end

    def favorite=(favorite)
      fail 'Must be a new favorite' unless favorite.new?
      @favorite = favorite
    end

    def save
      fetch_missing_data
      assign_params
      save_favorite
    end

    private

    def fetch_missing_data
      return if @params[:name]
      return unless web_page_contents

      @params[:name] = web_page_contents.title
    end

    def web_page_contents
      return unless @params[:url]

      @page ||= web_page.for(@params[:url])
    end

    def assign_params
      favorite.set_all @params
    end

    def save_favorite
      favorite.save
    end

    def favorite
      @favorite ||= Favorite.new
    end

    def web_page
      @web_page ||= WebPage
    end
  end
end
