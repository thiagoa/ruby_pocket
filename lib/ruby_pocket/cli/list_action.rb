require 'ruby_pocket/favorite_query'

module RubyPocket
  module Cli
    class ListAction
      def call(options)
        favorites = FavoriteQuery.where(options.values).all
        render favorites
      end

      private

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
