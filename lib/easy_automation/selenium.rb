require 'net/http'
# Original code is found on Selenium gem, I just have to modify stop command and specify a newer version of selenium-RC
#   it changed in selenium 1.0.3
# All credit is thanks to Selenium gem authors
module Selenium
  class SeleniumServer
    # Stops the Selenium server
    def stop
      Net::HTTP.get('localhost', '/selenium-server/driver/?cmd=shutDownSeleniumServer', @port_number)
    end

    private
    def SeleniumServer::jar_file
      File.join(File.dirname(__FILE__), '..', 'openqa', 'selenium-server.jar.txt')
    end
  end
end