module RubyPocket
  module Cli
    def self.dispatch(options)
      action = const_get("#{options.action.to_s.capitalize}Action")
      action.new.call options
    end
  end
end
