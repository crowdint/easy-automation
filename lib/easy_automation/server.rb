module EasyAutomation
  class Server
    class << self
      def rc force_reload = false
        if force_reload
          @selenium = build_server
        else
          @selenium ||= build_server
        end
      end

      def build_server
        if Runner.configuration.selenium_host.nil?
          Selenium::Server.new(Runner.configuration.selenium_port,
                               Runner.configuration.selenium_timeout)
        else
          EasyAutomation::RemoteServer.new
        end
      end
    end
  end
end