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
      lambda{my_suite.add(WrongTest)}.should raise_error(EasyAutomation::SuiteException)
    end
    it "should accept suites if they extend from EasyAutomation::Test" do
      class TestClass < EasyAutomation::Test
        def suite
          true
        end
        def method_name
          true
        end
      end
      my_suite = EasyAutomation::Suite.new
      my_suite.add(TestClass)
      my_suite.suite.size.should be(1)
    end
  end

end