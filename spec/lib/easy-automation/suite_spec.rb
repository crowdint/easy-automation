require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe EasyAutomation::Suite do

  subject { Suite }

  context "When adding new test suites to the main" do
    it "should raise an error if they dont extend from EasyAutomation::Test" do
      class WrongTest
        def suite
          true
        end
      end
      my_suite = EasyAutomation::Suite.new
      test  = WrongTest.new
      lambda{my_suite.add_suite(test)}.should raise_error(EasyAutomation::SuiteException)
    end
    it "should accept suites if they extend from EasyAutomation::Test" do
      class TestClass < EasyAutomation::Test
        def method_name
          true
        end
      end
      my_suite = EasyAutomation::Suite.new
      test  = TestClass.new('method_name', 'path')
      my_suite.add_suite(test)
      my_suite.suite.size.should be(1)
    end
  end

end