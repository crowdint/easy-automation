# Crowd Interactive Copyright 2011

#
# Framework Runner
#    EasyAutomation::Runner.configure do |config|
#      config.selenium_port = 44444
#      config.selenium_timeout = 1000
#      config.browser = "firefox"
#      config.url = "http://my_site:80"
#    end
#
#    my_suite = EasyAutomation::Suite.new
#    my_suite.add(MyTest)
#    EasyAutomation::Runner.run(my_suite)
#
# @author: Edwin Cruz (edwin.cruz@crowdint.com)
#
module EasyAutomation
  class RunnerSuiteException < Exception; end
  class Runner
    class << self
      def configuration
        @configuration ||= EasyAutomation::Config.new
      end

      def server
        @selenium_server ||= EasyAutomation::Server.new
      end

      def configure
        yield configuration
      end

      def run test_suite
        raise RunnerSuiteException.new('Wrong test suite class') unless test_suite.is_a?(EasyAutomation::Suite)
        server.selenium.start
        Test::Unit::UI::Console::TestRunner.run test_suite
        server.selenium.stop
      end
    end
  end
end