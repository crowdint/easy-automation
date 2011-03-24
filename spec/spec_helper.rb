require 'rubygems'
require 'bundler'

puts File.dirname(__FILE__)
require File.join(File.dirname(__FILE__), '..', 'lib/easy-automation')

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

class TestBlockClass
  def self.return_the_true
    true
  end
  def self.before_each_suite
    true
  end
  def self.before_each_test
    true
  end
  def self.after_each_suite
    true
  end
  def self.after_each_test
    true
  end
end