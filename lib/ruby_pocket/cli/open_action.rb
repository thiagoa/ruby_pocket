module RubyPocket
  module Cli
    class OpenAction
      OPEN_COMMANDS = {
        linux: 'xdg-open',
        mac: 'open',
        windows: 'start'
      }.freeze

      def call(options)
        favorite = Favorite[options.values[:id]]
        raise ArgumentError, 'Favorite not found!' unless favorite

        open_url(favorite.url)
      end

      private

      def open_url(favorite_url)
        command = OPEN_COMMANDS.fetch(OS.os, 'open')

        `#{command} #{favorite_url}`
      end
    end
  end
end
