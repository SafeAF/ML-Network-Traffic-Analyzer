# -*- encoding: utf-8 -*-
# stub: clearance 1.11.0 ruby lib

Gem::Specification.new do |s|
  s.name = "clearance"
  s.version = "1.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Dan Croak", "Eugene Bolshakov", "Mike Burns", "Joe Ferris", "Nick Quaranto", "Josh Nichols", "Matt Jankowski", "Josh Clayton", "Gabe Berke-Williams", "Greg Lazarev", "Mike Breen", "Prem Sichanugrist", "Harlow Ward", "Ryan McGeary", "Derek Prior", "Jason Morrison", "Galen Frechette", "Josh Steiner"]
  s.date = "2015-08-21"
  s.description = "Rails authentication & authorization with email & password."
  s.email = "support@thoughtbot.com"
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md"]
  s.homepage = "http://github.com/thoughtbot/clearance"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.4.8"
  s.summary = "Rails authentication & authorization with email & password."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bcrypt>, [">= 0"])
      s.add_runtime_dependency(%q<email_validator>, ["~> 1.4"])
      s.add_runtime_dependency(%q<rails>, [">= 3.1"])
    else
      s.add_dependency(%q<bcrypt>, [">= 0"])
      s.add_dependency(%q<email_validator>, ["~> 1.4"])
      s.add_dependency(%q<rails>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<bcrypt>, [">= 0"])
    s.add_dependency(%q<email_validator>, ["~> 1.4"])
    s.add_dependency(%q<rails>, [">= 3.1"])
  end
end
