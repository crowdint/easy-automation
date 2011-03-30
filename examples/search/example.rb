require 'rubygems'
require 'easy-automation'
Dir["#{File.dirname(__FILE__)}/*/*.rb"].each { |f| require f }

EasyAutomation::Runner.configure do |config|
  config.url = "http://www.google.com"
  config.add_browser "*firefox"
  config.add_browser "*googlechrome /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
  config.selenium_timeout = 10000
#  config.selenium_host = "remote_ip"
  config.before :all do
    puts 'Starting Tests'
  end
  config.after :all do
    puts 'Tests finished, halting'
  end
end

EasyAutomation::Args.parse(ARGV) unless ARGV.empty?

demo_suite = EasyAutomation::Suite.new('Example')
demo_suite.add(SimpleTest)
EasyAutomation::Runner.run demo_suite
