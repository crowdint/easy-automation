# Crowd Interactive Copyright 2011

#
# Base Test Class for Easy Automation Testing Framework
# Extend your test case from this class to get everything needed
# @author: Edwin Cruz (edwin.cruz@crowdint.com)
#
require 'test/unit'
module EasyAutomation
  class Test < Test::Unit::TestCase

    attr_accessor :data
    @path = nil

    #TODO figure out why we need to pass the path from a child class
    def initialize(test_methodname, path)
      @path = path
      super(test_methodname)
    end

    @data = {}

    #
    # Sets up the environment to run tests, decides whether build a new selenium client
    #   or use a global one.
    #
    def setup
      @webpage             = EasyAutomation::Server.rc.open(EasyAutomation::Runner.configuration.browser,
                                                            EasyAutomation::Runner.configuration.url)
      @data                = LoadData::load_test_data(self.class.to_s, @method_name, @path)
    end

    #
    # Executed after all tests, normally to stop selenium client.
    #
    def teardown
      @webpage.close
    end

  end
end