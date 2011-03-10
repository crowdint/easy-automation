require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe EasyAutomation::Test do

  subject { Test }

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
end