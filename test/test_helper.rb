require 'ruby_pocket'
RubyPocket.environment = 'TEST'

require 'open3'

require_relative '../config/config'
require_relative 'support/custom_assertions'
require_relative 'support/feature_assertions'

DatabaseCleaner.strategy = :truncation

class DefaultTestCase < MiniTest::Test
  include CustomAssertions

  alias :assert_not :refute
  alias :assert_not_empty :refute_empty
  alias :assert_not_match :refute_match
end

class DatabaseTestCase < DefaultTestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

class FeatureTestCase < DatabaseTestCase
  include FeatureAssertions

  private

  def run_command(command, **env)
    env = env_to_s(env)
    command = "#{env} bin/#{command}"

    Open3.popen3(command) do |_, stdout, stderr|
      ProgramOutput.new(stdout.read, stderr.read)
    end
  end

  def env_to_s(env)
    env = apply_env_defaults(env)
    env.map do |value|
      value[1] = "'#{value[1]}'"
      value.join('=')
    end.join(' ')
  end

  def apply_env_defaults(env)
    { RUBY_POCKET_ENV: 'TEST' }.merge(env)
  end

  ProgramOutput = Struct.new(:stdout, :stderr)
end
