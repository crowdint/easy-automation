require 'selenium'
require 'test/unit/ui/console/testrunner'
Dir.glob(File.join('.', 'lib', 'easy_automation', '*.rb')).each do |lib_file|
  require lib_file
end