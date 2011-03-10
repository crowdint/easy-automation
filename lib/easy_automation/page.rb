#Crowd Interactive Copyright 2011

# Common page actions for this framework
# @author Edwin Cruz (edwin.cruz@crowdint.com)
module EasyAutomation
  class Page < ::Selenium::WebPage

    @elements
    @browser

    # Default constructor
    def initialize(browser, path)
      @elements = LoadData.load_xpath_elements(self.class.to_s, path)
      super(browser, @elements.title)
      @browser = browser
    end

    ## Common page actions

    #
    # Gets body text
    #
    def html
      @browser.html()
    end

    #
    # Returns page title
    #
    def title
      @browser.title
    end

    #
    # Waits for page to load
    #
    def wait_page_load
      @browser.wait_for_load
    end

    #
    # it goes back one place in history
    #
    def go_back
      browser.browser.go_back()
      self.wait_page_load
    end

    #
    # Refresh current page and waits to be loaded
    #
    def refresh
      browser.browser.refresh
      self.wait_page_load
    end

    #
    # Returns all elements for current page
    #
    def elements
      @elements
    end
  end
end