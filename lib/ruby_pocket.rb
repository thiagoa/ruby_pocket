module RubyPocket
  RubyPocketError = Class.new StandardError

  class << self
    attr_accessor :environment

    def environment
      @environment || 'DEVELOPMENT'
    end
  end
end
