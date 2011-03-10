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
end