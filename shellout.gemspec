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

  s.add_development_dependency "bundler"
end
