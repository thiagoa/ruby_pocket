$:.push File.expand_path('../lib', __FILE__)

require 'ruby_pocket/version'

Gem::Specification.new do |s|
  s.name        = 'ruby_pocket'
  s.version     = RubyPocket::VERSION
  s.authors     = ['Thiago A. Silva']
  s.email       = ['thiagoaraujos@gmail.com']
  s.summary     = %q{A warm place to store your development references}
  s.description = %q{A command line client to store and manage development favorites}
  s.homepage    = 'http://github.com/thiagoa/ruby_pocket'
  s.license     = 'MIT'

  s.files = Dir['{config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']
  s.executables = ['pocket']

  s.add_runtime_dependency 'sqlite3', '~> 1.4', '>= 1.4.2'
  s.add_runtime_dependency 'sequel', '~> 5.45', '>= 5.45.0'
  s.add_runtime_dependency 'mechanize', '~> 2.8', '>= 2.8.1'
  s.add_runtime_dependency 'terminal-table', '~> 3.0', '>= 3.0.1'

  s.add_development_dependency 'rake', '~> 13.0', '>= 13.0.3'
  s.add_development_dependency 'minitest', '~> 5.14', '>= 5.14.4'
  s.add_development_dependency 'testrbl', '~> 0.9', '>= 0.9.0'
  s.add_development_dependency 'database_cleaner', '~> 2.0', '>= 2.0.1'
  s.add_development_dependency 'database_cleaner-sequel', '~> 2.0', '>= 2.0.0'
  s.add_development_dependency 'webmock', '~> 3.13', '>= 3.13.0'
  s.add_development_dependency 'simplecov', '~> 0.21', '>= 0.21.2'
  s.add_development_dependency 'pry', '~> 0.14', '>= 0.14.1'
end
