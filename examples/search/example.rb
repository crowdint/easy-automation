require 'rubygems'
require 'ruby-debug'
require '../../lib/easy-automation'
require 'pages/home_page'
require 'pages/results_page'
require 'tests/simple_test'
require 'easy_automation/runner'
require 'easy_automation/config'
require 'easy_automation/load_data'
require 'easy_automation/data_elements'
require 'easy_automation/suite'
require 'easy_automation/server'

EasyAutomation::Runner.configure do |config|
  config.url = "http://www.google.com"
  config.browser = "*safari"
end

demo_suite = EasyAutomation::Suite.new('Example')
demo_suite.add(SimpleTest)
EasyAutomation::Runner.run demo_suite
