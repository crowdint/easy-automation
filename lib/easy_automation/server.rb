module EasyAutomation
  class Server
    def self.rc
      @selenium ||= Selenium::Server.new(EasyAutomation::Runner.configuration.selenium_port,
                                       EasyAutomation::Runner.configuration.selenium_timeout)
    end
  end
end