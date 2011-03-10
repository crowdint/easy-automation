require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe EasyAutomation::Test do

  subject { Test }

  before :each do
    fake_server = mock(Selenium::Server)
    fake_driver = mock(Selenium::SeleniumDriver)
    fake_server.stub(:open).and_return(fake_driver)
    fake_driver.stub(:close).and_return(true)
    Selenium::Server.stub!(:new).and_return(fake_server)
    EasyAutomation::Server.stub(:rc).and_return(fake_server)
  end

  context "#Loading data info" do
    it "should load data/filename.yml with @current_test one" do
      home_test = HomeTest.new('one')
      home_test.setup
      home_test.data.title.should == 'First block'
    end
    it "should load data/filename.yml with @current_test two" do
      home_test = HomeTest.new('one')
      home_test.setup
      home_test.data.title.should == 'First block'
    end
  end

  context "when opening web pages" do
    it "should initialize it's selenium rc if it's not been initalized" do
      test_spec = HomeTest.new('one')
      test_spec.setup
      test_spec.teardown
    end
  end
end