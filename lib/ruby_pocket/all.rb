require 'ruby_pocket'

Dir.glob(File.join(__dir__, '**', '*.rb')).each do |file|
  require file
end
