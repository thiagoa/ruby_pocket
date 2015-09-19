$:.push File.expand_path('../lib', __FILE__)

require 'ruby_pocket/version'

Gem::Specification.new do |s|
  s.name        = 'ruby_pocket'
  s.version     = RubyPocket::VERSION
  s.authors     = ['Thiago A. Silva']
  s.email       = ['thiagoaraujos@gmail.com']
  s.summary     = %q{A warm place to store precious development references}
  s.description = %q{A command line client to store and manage development favorites}
  s.homepage    = 'http://github.com/thiagoa/ruby_pocket'
  s.license     = 'MIT'

  s.files = Dir['{config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']
  s.executables = ['pocket']

  s.add_runtime_dependency 'sqlite3', '~> 1.3', '>= 1.3.10'
  s.add_runtime_dependency 'sequel', '~> 4.26', '>= 4.26.0'
  s.add_runtime_dependency 'mechanize', '~> 2.7', '>= 2.7.3'
  s.add_runtime_dependency 'terminal-table', '~> 1.5', '>= 1.5.2'

  s.add_development_dependency 'rake', '~> 10.4', '>= 10.4.2'
  s.add_development_dependency 'minitest', '~> 5.8', '>= 5.8.0'
  s.add_development_dependency 'testrbl', '~> 0.6', '>= 0.6.0'
  s.add_development_dependency 'database_cleaner', '~> 1.5', '>= 1.5.0'
  s.add_development_dependency 'webmock', '~> 1.21', '>= 1.21.0'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.4', '>= 0.4.8'
end
