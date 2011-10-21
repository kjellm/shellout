# encoding: utf-8

Gem::Specification.new do |s|
  s.name        = "shellout"
  s.version     = "0.1"
  s.authors     = ["Kjell-Magne Øierud"]
  s.email       = ["kjellm@acm.org"]
  s.homepage    = "https://github.com/kjellm/shellout"
  s.summary     = %q{Tools for writing terminal interfaces}
  s.description = %q{Contains classes for printing tables and boxes}
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"

  if RUBY_PLATFORM.downcase.include?("darwin")
    s.add_development_dependency 'rb-fsevent'
    s.add_development_dependency 'growl_notify'
  end
end