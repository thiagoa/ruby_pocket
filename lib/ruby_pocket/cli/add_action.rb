module RubyPocket
  module Cli
    class AddAction
      def call(options)
        creator = FavoriteCreator.new(options.values)
        creator.save

        puts "Favorite '#{creator.name}' created!"
      end
    end
  end
end
