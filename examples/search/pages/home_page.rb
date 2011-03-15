class HomePage < BasePage
  def query
    browser.text_field(:name, elements.query)
  end

  def submit
    browser.button(elements.submit)
  end
end
