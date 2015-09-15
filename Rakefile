require 'pathname'
require 'rake'

$LOAD_PATH << Pathname(__dir__).join('config')
$LOAD_PATH << Pathname(__dir__).join('lib')

desc 'Run all tests'
task :test do |t|
  require 'minitest/autorun'

  $LOAD_PATH << Pathname(__dir__).join('test')

  test_files = Pathname.glob('test/**/*_test.rb')
  test_files.each { |file | require file.expand_path }
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

task default: :test
