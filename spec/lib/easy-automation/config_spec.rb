require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe EasyAutomation::Config do
  subject {Config}

  context "#hooks" do
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

  context "#browsers" do
    context "single browser" do
      it "should allow single browser assignment, backward compatibility" do
        config = EasyAutomation::Config.new
        config.browser = "* chrome"
        config.browsers.size.should == 1
        config.current_browser.should == config.browsers.first
      end
      it "should allow to specify multiples browsers" do
        config = EasyAutomation::Config.new
        config.add_browser "* chrome"
        config.browsers << "* firefox"
        config.add_browser "* safari"
        config.browsers.size.should == 3
        config.current_browser.should == config.browsers.first
      end
    end
  end
end