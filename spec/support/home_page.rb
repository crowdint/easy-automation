class HomePage < EasyAutomation::Page

  def initialize(browser, extra = nil)
    super(browser, File.expand_path(File.dirname(__FILE__)))
  end
  
  def login_link
    browser.link(:text, @elements.login_link)
  end

  def query_field
    browser.text_field(:id, @elements.query_field)
  end

  def submit_query
    browser.button(:xpath, @elements.submit)
  end
end