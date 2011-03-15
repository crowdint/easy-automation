# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "easy_automation/version"

Gem::Specification.new do |s|
  s.name        = "easy-automation"
  s.version     = EasyAutomation::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Edwin Cruz"]
  s.email       = ["edwin@crowdint.com"]
  s.homepage    = "http://rubygems.org/gems/easy-automation"
  s.summary     = %q{Friendly Automation Testing Framework}
  s.description = %q{Friendly Automation Testing Framework, tired of update every single test when developers change an XPath, id, class, etc? This is for you.}

  s.rubyforge_project = "easy-automation"

  s.files         = `git ls-files`.split("\n").reject {|item| item.include?('examples/')}
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('Selenium')
  s.add_development_dependency("rspec", ">= 2.3.0")
end
