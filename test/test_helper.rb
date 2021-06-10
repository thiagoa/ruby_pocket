$LOAD_PATH << __dir__

require 'simplecov'

SimpleCov.start

require 'ruby_pocket'

RubyPocket.environment = 'TEST'

require_relative '../config/config'

require 'database_cleaner'
require 'minitest/autorun'
require 'database_cleaner/sequel'

require_relative 'support/default_test_case'
require_relative 'support/database_test_case'
require_relative 'support/feature_test_case'

DatabaseCleaner[:sequel].strategy = :truncation
