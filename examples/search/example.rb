require 'rubygems'
require 'easy-automation'
Dir["#{File.dirname(__FILE__)}/*/*.rb"].each { |f| require f }

EasyAutomation::Runner.configure do |config|
  config.url = "http://www.google.com"
  config.browser = "*safari"
  config.before :all do
    puts 'Starting Tests'
  end
  config.after :all do
    puts 'Tests finished, halting'
  end
end

demo_suite = EasyAutomation::Suite.new('Example')
demo_suite.add(SimpleTest)
EasyAutomation::Runner.run demo_suite
