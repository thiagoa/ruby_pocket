require 'ruby_pocket'
RubyPocket.environment = 'TEST'

require 'database_cleaner'

require_relative '../config/config'

require_relative 'support/default_test_case'
require_relative 'support/database_test_case'
require_relative 'support/feature_test_case'

DatabaseCleaner.strategy = :truncation
