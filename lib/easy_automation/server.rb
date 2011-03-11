module EasyAutomation
  class Server
    def self.rc
      @selenium ||= Selenium::Server.new(Runner.configuration.selenium_port,
                                       Runner.configuration.selenium_timeout)
    end
  end
end