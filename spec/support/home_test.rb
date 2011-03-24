class HomeTest < EasyAutomation::Test

  def initialize(test_name)
    super(test_name, File.expand_path(File.dirname(__FILE__)))
  end
  
  def one
  end

  def two
  end

  def test_hooks
    true
  end
end