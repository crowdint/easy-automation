module EasyAutomation
  class RemoteServer
    def driver(browser_start_command, browser_url, port, timeout)
      ::Selenium::SeleniumDriver.new('localhost', port, browser_start_command, browser_url, timeout * 1000)
    end

    def open(browser_start_command, browser_url)
      url     = URI.parse(browser_url)
      browser = driver(browser_start_command,
                       URI::Generic::new(url.scheme, url.userinfo, url.host, url.port, nil, nil, nil, nil, nil),
                       Runner.configuration.selenium_port,
                       Runner.configuration.selenium_timeout)
      browser.start
      browser.open(url.request_uri)
      page = ::Selenium::WebPage.new(browser)
      page.wait_for_load
      page
    end

    def start
    end

    def stop
    end
  end
end