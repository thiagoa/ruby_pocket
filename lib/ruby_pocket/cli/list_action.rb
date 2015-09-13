module RubyPocket
  module Cli
    class ListAction
      def call(options)
        favorites = fetch_favorites(options.values)
        render favorites
      end

      private

      def fetch_favorites(values)
        if values[:tag_names]
          find_favorites_by_tags(values[:tag_names])
        else
          Favorite.all
        end
      end

      def find_favorites_by_tags(tag_names)
        query = find_tags(tag_names).reduce(Favorite) do |scope, tag|
          scope.where(tags: tag)
        end

        query.all
      end

      def find_tags(names)
        names.map do |name|
          Tag.find(name: name).tap do |tag|
            fail ArgumentError, "Tag #{name} not found" unless tag
          end
        end
      end

      def render(favorites)
        return puts 'Your Ruby Pocket is empty' if favorites.empty?

        headings = %w(ID Name Tags)
        rows = table_rows(favorites)

        puts Terminal::Table.new headings: headings, rows: rows
      end

      def table_rows(favorites)
        rows = favorites.map do |f|
          [f.id, f.name, f.tags.map(&:name).join(',')]
        end

        add_placeholders(rows)
      end

      def add_placeholders(rows)
        rows.each do |row|
          row.map! do |value|
            (value.to_s.empty? && '-') || value
          end
        end
      end
    end
  end
end
