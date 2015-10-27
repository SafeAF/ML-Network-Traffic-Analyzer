# -*- encoding: utf-8 -*-
# stub: phrasing 3.2.10 ruby lib

Gem::Specification.new do |s|
  s.name = "phrasing"
  s.version = "3.2.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Tomislav Car", "Damir Svrtan"]
  s.date = "2015-10-02"
  s.description = "Phrasing!"
  s.email = "contact@infinum.co"
  s.homepage = "http://github.com/infinum/phrasing"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Edit phrases inline for Rails applications!"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.2.0"])
      s.add_runtime_dependency(%q<railties>, [">= 3.2"])
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_runtime_dependency(%q<jquery-cookie-rails>, [">= 0"])
      s.add_runtime_dependency(%q<sass>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.2.0"])
      s.add_dependency(%q<railties>, [">= 3.2"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<jquery-cookie-rails>, [">= 0"])
      s.add_dependency(%q<sass>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.2.0"])
    s.add_dependency(%q<railties>, [">= 3.2"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<jquery-cookie-rails>, [">= 0"])
    s.add_dependency(%q<sass>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
