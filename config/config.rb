require 'bundler'

RubyPocket.environment = ENV['RUBY_POCKET_ENV'] if ENV['RUBY_POCKET_ENV']

Bundler.require :default, RubyPocket.environment.downcase

if RubyPocket.environment == 'TEST' && ENV['MOCK_FEATURE'] == 'add'
  require_relative '../test/support/add_feature_mocker'
  AddFeatureMocker.new.run
end

require_relative 'database'
