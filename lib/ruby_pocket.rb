require 'etc'

module RubyPocket
  RubyPocketError = Class.new StandardError

  class << self
    attr_accessor :environment

    def environment
      @environment || 'PRODUCTION'
    end

    def setup_data_dir
      return unless environment == 'PRODUCTION'
      return if Dir.exist?(data_dir)

      Dir.mkdir data_dir
    end

    def data_dir
      @data_dir ||= File.join(home_dir, '.ruby_pocket')
    end

    private

    def home_dir
      Dir.home(Etc.getlogin)
    end
  end
end
