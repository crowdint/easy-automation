require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe EasyAutomation::Runner do

  subject { Runner }

  context "when configuring runner" do
    context "selenium params" do
      it "should default params" do
        EasyAutomation::Runner.configuration.selenium_port.should be(4444)
        EasyAutomation::Runner.configuration.selenium_timeout.should be(1000)
        EasyAutomation::Runner.configuration.browser.should == "Firefox"
        EasyAutomation::Runner.configuration.url.should == "http://www.google.com"
      end

      it "should set correct params" do
        EasyAutomation::Runner.configure do |config|
          config.selenium_port    = 44444
          config.selenium_timeout = 40000
          config.browser          = "Chrome"
          config.url              = "http://www.yahoo.com"
        end
        EasyAutomation::Runner.configuration.selenium_port.should be(44444)
        EasyAutomation::Runner.configuration.selenium_timeout.should be(40000)
        EasyAutomation::Runner.configuration.browser.should == "Chrome"
        EasyAutomation::Runner.configuration.url.should == "http://www.yahoo.com"
      end
    end
  end

  context "when running tests" do
    before :each do
      @rc = mock(EasyAutomation::Server)
      EasyAutomation::Server.stub(:rc).and_return(@rc)
      Test::Unit::UI::Console::TestRunner.stub(:run).and_return(true)      
      @rc.should_receive(:start)
      @rc.should_receive(:stop)
    end
    it "should accept EasyAutomation::Suite classes" do
      suite = EasyAutomation::Suite.new
      lambda { EasyAutomation::Runner.run suite }.should_not raise_error(EasyAutomation::RunnerSuiteException)
    end
    context "before and after all hooks" do
      it "should call before all hook when running suites" do
        TestBlockClass.should_receive(:return_the_true)
        EasyAutomation::Runner.configure do |config|
          config.before :all do
            TestBlockClass.return_the_true
          end
        end
        EasyAutomation::Runner.run EasyAutomation::Suite.new('test')
      end
      it "should call after all hook when running suites" do
        TestBlockClass.should_receive(:return_the_true).at_least(2).times()
        EasyAutomation::Runner.configure do |config|
          config.after :all do
            TestBlockClass.return_the_true
          end
        end
        EasyAutomation::Runner.run EasyAutomation::Suite.new('test')
      end
    end
  end
end