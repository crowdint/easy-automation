require 'easy_automation/test'
class SimpleTest < EasyAutomation::Test
  def initialize test_methodname
    super(test_methodname, File.dirname(__FILE__))
  end

  def test_search_selenium
    main_page = HomePage.new(@webpage)
    results_page = ResultsPage.new(@webpage)
    main_page.query.enter data.query_text
    main_page.submit.click
    sleep(3) #Just for demo purposes
    assert results_page.first_add.include?(data.query_text)
  end
end