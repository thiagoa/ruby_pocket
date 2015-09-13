require 'bundler'

RubyPocket.environment = ENV['RUBY_POCKET_ENV'] if ENV['RUBY_POCKET_ENV']

Bundler.require :default, RubyPocket.environment.downcase

require_relative 'database'
