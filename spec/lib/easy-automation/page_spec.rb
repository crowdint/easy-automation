require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe EasyAutomation::Page do

  subject {Page}

  context "#Loading elements info" do
    before :each do
      @browser = Browser.new
    end
    it "should load elements/filename.yml" do
      home_page = HomePage.new(@browser)
      home_page.elements.login_link.should == "Log In"
      home_page.elements.query_field.should == "q"
      home_page.elements.submit.should == "xpath=id('submit')"
      home_page.elements.title.should == "Home Page"
    end
  end
end