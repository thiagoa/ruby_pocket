module RubyPocket
  RubyPocketError = Class.new StandardError

  class << self
    attr_accessor :environment

    def environment
      @environment || 'PRODUCTION'
    end
  end
end
