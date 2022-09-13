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
        command = OPEN_COMMANDS.fetch(os, 'open')

        `#{command} #{favorite_url}`
      end

      def os
        OS.os.tap do |os|
          abort 'Operating System not supported!' unless os
        end
      end
    end
  end
end
