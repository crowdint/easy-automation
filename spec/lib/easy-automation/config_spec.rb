require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe EasyAutomation::Config do
  subject {Config}

  context "before hooks" do
    context "when specifying any hook" do
      before :each do
        @config = EasyAutomation::Config.new
        @config.before(:each) do
           TestBlockClass.return_the_true
        end
      end
      it "should save it" do
        @config.hooks[:before][:each].should be_is_a(Proc)
      end
      it "should execute it when called" do
        TestBlockClass.should_receive(:return_the_true)
        @config.execute(:before, :each)
      end
    end
  end
end