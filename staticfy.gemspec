# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "staticfy/version"

Gem::Specification.new do |s|
  s.name        = "staticfy"
  s.version     = Staticfy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Wilker Lúcio"]
  s.email       = ["wilkerlucio@gmail.com"]
  s.homepage    = "https://www.github.com/wilkerlucio/staticfy"
  s.summary     = %q{Turn online sites into html static ones.}
  s.description = %q{This gem provides a simple tool to make a full online website into a static one. This can be useful for companies that needs to take system off from a client, but want to keep it online in static manner.}

  s.rubyforge_project = "staticfy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("anemone", "0.6.1") # currently the Staticfy do some hacks on Anemone, so, specifique version may be required

  s.add_development_dependency("mocha")
end
