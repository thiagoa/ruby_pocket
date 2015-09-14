require 'support/database_test_case'
require 'support/feature_assertions'
require 'open3'

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
