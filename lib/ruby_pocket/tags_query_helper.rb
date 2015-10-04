require 'ruby_pocket/tag'

module RubyPocket
  module TagsQueryHelper
    private

    def find_all_tags(names)
      names.map { |name| find_tag_match(name) }
    end

    def find_tag_match(name)
      if name.start_with?(?/) && name.end_with?(?/)
        find_partial_tag_match(name)
      else
        find_exact_tag_match(name)
      end
    end

    def find_exact_tag_match(name)
      found_tag = Tag.find(name: name).tap do |tag|
        fail ArgumentError, "Tag #{name} not found" unless tag
      end

      { tags: found_tag }
    end

    def find_partial_tag_match(name)
      tags = Tag.where(Sequel.like(:name, name.gsub(?/, ?%))).all
      Sequel.or(tags: tags)
    end
  end
end
