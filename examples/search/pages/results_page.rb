require 'easy_automation/page'
class ResultsPage < EasyAutomation::Page
  def initialize(browser)
    super(browser, File.dirname(__FILE__))
  end
  
  def first_add
    browser.text(elements.first_add)
  end
end