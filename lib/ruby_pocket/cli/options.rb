module RubyPocket
  module Cli
    class Options
      attr_reader :action, :values

      def initialize
        @values = {}
      end

      def action=(action)
        if @action
          fail ArgumentError, "Can't #{action} and #{@action} at the same time"
        end

        @action = action
      end

      def validate!
        fail ArgumentError, 'You need to supply an action' unless action
      end
    end
  end
end
