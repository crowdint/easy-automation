require 'rubygems'
require 'bundler'

require File.join(File.dirname(__FILE__), '..', 'lib/easy-automation')

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

