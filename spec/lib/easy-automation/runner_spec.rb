require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe EasyAutomation::Runner do

  subject { Runner }

  context "when configuring runner" do
    it "Should default params" do
      EasyAutomation::Runner.configuration.selenium_port.should be(4444)
      EasyAutomation::Runner.configuration.selenium_timeout.should be(1000)
      EasyAutomation::Runner.configuration.browser.should == "Firefox"
      EasyAutomation::Runner.configuration.url.should == "http://www.google.com"
    end

    it "Should set correct params" do
      EasyAutomation::Runner.configure do |config|
        config.selenium_port = 44444
        config.selenium_timeout = 40000
        config.browser = "Chrome"
        config.url = "http://www.yahoo.com"
      end
      EasyAutomation::Runner.configuration.selenium_port.should be(44444)
      EasyAutomation::Runner.configuration.selenium_timeout.should be(40000)
      EasyAutomation::Runner.configuration.browser.should == "Chrome"
      EasyAutomation::Runner.configuration.url.should == "http://www.yahoo.com"
    end
  end

  context "when running tests" do
    before :each do
      @rc = mock(EasyAutomation::Server)
      EasyAutomation::Server.stub(:rc).and_return(@rc)
    end
    it "should accept EasyAutomation::Suite classes" do
      Test::Unit::UI::Console::TestRunner.stub(:run).and_return(true)
      @rc.should_receive(:start)
      @rc.should_receive(:stop)
      suite = EasyAutomation::Suite.new
      lambda {EasyAutomation::Runner.run suite}.should_not raise_error(EasyAutomation::RunnerSuiteException)
    end
  end
end