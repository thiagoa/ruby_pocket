require 'ruby_pocket/favorite'

module RubyPocket
  class FavoriteQuery
    extend Forwardable

    def self.where(options)
      new.where(options)
    end

    delegate :all => :@scope

    def initialize(scope = nil)
      @scope = scope || Favorite
    end

    def where(options)
      if options[:tag_names]
        tags = Tag.find_all(options[:tag_names])
        @scope = where_tags(tags)
      end

      self
    end

    private

    def where_tags(tags)
      tags.reduce(@scope) do |scope, tag|
        scope.where(tags: tag)
      end
    end
  end
end
