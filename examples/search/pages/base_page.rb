class BasePage < EasyAutomation::Page
  def initialize(webpage)
    super(webpage, File.dirname(__FILE__))
  end
end