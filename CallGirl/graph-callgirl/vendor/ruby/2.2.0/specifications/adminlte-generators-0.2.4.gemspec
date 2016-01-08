# -*- encoding: utf-8 -*-
# stub: adminlte-generators 0.2.4 ruby lib

Gem::Specification.new do |s|
  s.name = "adminlte-generators"
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Pavlo Babenko"]
  s.date = "2015-06-18"
  s.description = "AdminLTE-generators provides AdminLTE generators for Rails 4."
  s.email = ["pavlo.babenko@gmail.com"]
  s.homepage = "https://github.com/chukcha-wtf/adminlte-generators"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "AdminLTE-generators provides AdminLTE generators for Rails 4."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_runtime_dependency(%q<railties>, [">= 3.1.0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<railties>, [">= 3.1.0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<railties>, [">= 3.1.0"])
  end
end
