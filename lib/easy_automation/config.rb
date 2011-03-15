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
    attr_reader :hooks

    #
    # Default settings for selenium RC
    #
    def initialize
      @selenium_port = 4444
      @selenium_timeout = 1000
      @browser = "Firefox"
      @url = "http://www.google.com"
      @hooks = {:before => {}, :after =>{}}
    end

    def before hook, &block
      @hooks[:before].merge!({hook.to_sym => block}) if block_given?
    end

    def after hook, &block
      @hooks[:after].merge!({hook.to_sym => block}) if block_given?
    end

    def execute type, hook_name
      @hooks[type.to_sym][hook_name.to_sym].call if @hooks[type.to_sym][hook_name.to_sym]
    end

    def load_files pattern
      puts '888888888888 ENTRE!!!'
      Dir[pattern].each { |f| require f }
    end
  end
end