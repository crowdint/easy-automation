require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe EasyAutomation::Runner do

  subject { Runner }

  context "when configuring runner" do
    context "selenium params" do
      it "should default params" do
        EasyAutomation::Runner.configuration.selenium_port.should be(4444)
        EasyAutomation::Runner.configuration.selenium_timeout.should be(4000)
        EasyAutomation::Runner.configuration.browsers.should == ["* firefox"]
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
        EasyAutomation::Runner.configuration.browsers.should == ["Chrome"]
        EasyAutomation::Runner.configuration.url.should == "http://www.yahoo.com"
      end
    end
  end

  context "when running tests" do
    before :each do
      @rc = mock(EasyAutomation::Server)
      EasyAutomation::Server.stub(:rc).and_return(@rc)
      Test::Unit::UI::Console::TestRunner.stub(:run).and_return(true)
      @rc.should_receive(:start).at_least(1).times()
      @rc.should_receive(:stop).at_least(1).times()
      EasyAutomation::Runner.configuration.selenium_host = ''
    end
    it "should accept EasyAutomation::Suite classes" do
      suite = EasyAutomation::Suite.new
      lambda { EasyAutomation::Runner.run suite }.should_not raise_error(EasyAutomation::RunnerSuiteException)
    end
    it "should call before all hook when running suites" do
      TestBlockClass.should_receive(:before_each_suite)
      EasyAutomation::Runner.configure do |config|
        config.before :all do
          TestBlockClass.before_each_suite
        end
      end
      EasyAutomation::Runner.run EasyAutomation::Suite.new('test')
    end
    it "should call after all hook when running suites" do
      TestBlockClass.should_receive(:after_each_suite).at_least(1).times()
      EasyAutomation::Runner.configure do |config|
        config.after :all do
          TestBlockClass.after_each_suite
        end
      end
      EasyAutomation::Runner.run EasyAutomation::Suite.new('test')
    end
  end

  context "before and after each test hooks" do
    before :each do
      EasyAutomation::Runner.configure do |config|
        config.before :each_test do
          TestBlockClass.before_each_test
        end
        config.after :each_test do
          TestBlockClass.after_each_test
        end
      end
      @suite = EasyAutomation::Suite.new('test')
      @suite.add(HomeTest)
      rc = mock(EasyAutomation::Server)
      webpage = mock(Selenium::Server)
      EasyAutomation::Server.stub(:rc).and_return(rc)
      rc.should_receive(:start)
      rc.should_receive(:stop)
      rc.should_receive(:open).and_return(webpage)
      webpage.should_receive(:close).any_number_of_times
    end
    it "should call :before_each_test before any test" do
      TestBlockClass.should_receive(:before_each_test)
      EasyAutomation::Runner.run @suite
    end
    it "should call :after_each_test after any test" do
      TestBlockClass.should_receive(:after_each_test)
      EasyAutomation::Runner.run @suite
    end
  end

  context "Remote Selenium server" do
    context "when specifying selenium_host" do
      it "should not start selenium server locally" do
        rc = mock(EasyAutomation::RemoteServer)
        rc.should_receive(:start)
        rc.should_receive(:stop)
        EasyAutomation::Runner.configure do |config|
          config.selenium_host = "remote_host"
        end
        EasyAutomation::RemoteServer.should_receive(:new).and_return(rc)
        EasyAutomation::Server.rc true
        Selenium::Server.should_not_receive(:new)
        EasyAutomation::Runner.run EasyAutomation::Suite.new('test')
      end
    end
  end

  context "multiple browsers" do
    before :each do
      rc = mock(EasyAutomation::RemoteServer)
      webpage = mock(Selenium::Server)
      rc.should_receive(:start)
      rc.should_receive(:stop)
      rc.should_receive(:open).any_number_of_times().and_return(webpage)
      webpage.should_receive(:close).any_number_of_times()
      EasyAutomation::RemoteServer.should_receive(:new).and_return(rc)
    end
    it "should run all tests against every single browser specified on config" do
      EasyAutomation::Runner.configure do |config|
        config.selenium_host = "localhost"
        config.add_browser "*firefox"
        config.add_browser "*safari"
      end
      EasyAutomation::Server.rc true
      test_suite = EasyAutomation::Suite.new('test')
      Test::Unit::UI::Console::TestRunner.should_receive(:run).at_least(2).times()
      test_suite.add(HomeTest)
      EasyAutomation::Runner.run test_suite
    end
  end
end