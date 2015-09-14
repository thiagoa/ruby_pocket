module RubyPocket
  module Cli
    class OpenAction
      def call(options)
        favorite = Favorite[options.values[:id]]
        fail ArgumentError, 'Favorite not found!' unless favorite

        %x(open #{favorite.url})
      end
    end
  end
end
