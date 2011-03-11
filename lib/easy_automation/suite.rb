module EasyAutomation
  class SuiteException < Exception; end
  class Suite
    attr_reader :suite

    def initialize name = "Test Suite"
      @suite = ::Test::Unit::TestSuite.new(name)
    end

    def add test_name
      raise SuiteException.new('Wrong test class, please extend it from EasyAutomation::Test') unless test_name < EasyAutomation::Test
      @suite << test_name.suite
    end
  end
end
