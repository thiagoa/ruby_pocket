module RubyPocket
  module Cli
    class DeleteAction
      def call(options)
        options.values[:ids].each do |id|
          favorite = Favorite[id]

          next puts "Favorite with ID #{id} not found!" unless favorite

          favorite.destroy
          puts "Favorite '#{favorite.name}' deleted"
        end
      end
    end
  end
end
