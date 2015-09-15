require 'bundler'

RubyPocket.environment = ENV['RUBY_POCKET_ENV'] if ENV['RUBY_POCKET_ENV']
RubyPocket.setup_data_dir

Bundler.require :default, RubyPocket.environment.downcase

if RubyPocket.environment.test? && ENV['MOCK_FEATURE'] == 'add'
  require_relative '../test/support/add_feature_mocker'
  AddFeatureMocker.new.run
end

require_relative 'database'
