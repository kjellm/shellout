# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require 'shellout/version'

Gem::Specification.new do |s|
  s.name        = "shellout"
  s.version     = Shellout::VERSION
  s.authors     = ["Kjell-Magne Øierud"]
  s.email       = ["kjellm@acm.org"]
  s.homepage    = "https://github.com/kjellm/shellout"
  s.license     = "MIT"
  s.summary     = %q{Tools for writing terminal interfaces}
  s.description = %q{Contains classes for printing tables and boxes}
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", '2.14.1'
  s.add_development_dependency "guard", '1.8.2'
  s.add_development_dependency "guard-rspec", '3.0.2'
  s.add_development_dependency "rake", '10.1.0'
  s.add_development_dependency "cucumber", '1.3.10'
  s.add_development_dependency "aruba", '0.5.3'

  if RUBY_PLATFORM.downcase.include?("darwin")
    s.add_development_dependency 'rb-fsevent'
    s.add_development_dependency 'growl_notify'
  end
end
