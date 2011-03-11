require 'easy_automation/page'
class HomePage < EasyAutomation::Page
  def initialize(webpage)
    super(webpage, File.dirname(__FILE__))
  end

  def query
    browser.text_field(:name, elements.query)
  end

  def submit
    browser.button(elements.submit)
  end
end