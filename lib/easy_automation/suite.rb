module EasyAutomation
  class SuiteException < Exception; end
  class Suite
    attr_reader :suite

    def initialize name = "Test Suite"
      @suite = ::Test::Unit::TestSuite.new(name)
    end

    def add_suite suite
      raise SuiteException.new('Wrong test class, please extend it from EasyAutomation::Test') unless suite.is_a?(EasyAutomation::Test)
      @suite << suite
    end
  end
end
