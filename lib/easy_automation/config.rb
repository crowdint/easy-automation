# Crowd Interactive Copyright 2011

#
# Config class used by Runner.configure it controls selenium behaviour
# @author: Edwin Cruz (edwin.cruz@crowdint.com)
#
module EasyAutomation
  class Config
    attr_accessor :selenium_port
    attr_accessor :selenium_timeout
    attr_accessor :browser
    attr_accessor :url

    #
    # Default settings for selenium RC
    #
    def initialize
      @selenium_port = 4444
      @selenium_timeout = 1000
      @browser = "Firefox"
      @url = "http://www.google.com"
    end
  end
end