require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe EasyAutomation::Args do
  subject {Args}

  describe "When specifying no args" do
    it "should not alter configuration" do
      EasyAutomation::Runner.configure do |config|
        config.url = "not_modified"
      end
      argv = []
      EasyAutomation::Args.parse(argv)
      EasyAutomation::Runner.configuration.url.should == "not_modified"
    end
  end
  describe "When specifying args" do
    it "should not alter configuration" do
      argv = ["--url=testing_args"]
      EasyAutomation::Args.parse(argv)
      EasyAutomation::Runner.configuration.url.should == "testing_args"
    end
  end

  describe "when specifying wrong params" do
    it "should not raise any exception" do
      EasyAutomation::Args.should_receive(:usage).and_return(true)
      argv = ["--wrong_param=testing_args"]
      EasyAutomation::Args.parse(argv)
    end
  end
end