require 'ruby_pocket/favorite'
require 'ruby_pocket/tags_query_helper'

module RubyPocket
  class FavoriteQuery
    extend Forwardable
    include TagsQueryHelper

    def self.where(options)
      new.where(options)
    end

    delegate :all => :@scope

    def initialize(scope = nil)
      @scope = scope || Favorite
    end

    def where(options)
      if options[:tag_names]
        tags = find_all_tags(options[:tag_names])
        @scope = where_tags(tags)
      end

      self
    end

    private

    def where_tags(tags)
      tags.reduce(@scope) do |scope, tag|
        scope.where(tag)
      end
    end
  end
end
