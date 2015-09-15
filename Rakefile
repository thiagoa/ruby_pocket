require 'pathname'
require 'rake'

%w(config lib test).each do |dir|
  $LOAD_PATH << Pathname(__dir__).join(dir)
end

def run_tests(test_files)
  require 'minitest/autorun'

  test_files.each { |file | require file.expand_path }
end

desc 'Run unit tests'
task :test do
  all = Pathname.glob('test/**/*_test.rb')

  run_tests(all.reject { |f| f.to_s =~ /features/ })
end

namespace :test do
  desc 'Run feature tests'
  task :feature do
    feature = Pathname.glob('test/ruby_pocket/features/**/*_test.rb')

    run_tests(feature)
  end

  desc 'Run all tests'
  task :all do
    all = Pathname.glob('test/**/*_test.rb')

    run_tests(all)
  end
end

desc 'Run an IRB console'
task :console do |t|
  require 'irb'
  require 'ruby_pocket'
  require 'config'
  require 'ruby_pocket/all'

  ARGV.clear

  IRB.start
end

task default: 'test:all'
