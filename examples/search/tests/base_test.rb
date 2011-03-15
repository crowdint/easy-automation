class BaseTest < EasyAutomation::Test
  def initialize test_methodname
    super(test_methodname, File.dirname(__FILE__))
  end
end
