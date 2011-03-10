module EasyAutomation
  class Server
    attr_reader :selenium

    def initialize
      @selenium = Selenium::Server.new(EasyAutomation::Runner.configuration.selenium_port,
                                       EasyAutomation::Runner.configuration.selenium_timeout)
    end
  end
end