# -*- encoding: utf-8 -*-
# stub: gruff 0.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "gruff"
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Geoffrey Grosenbach", "Uwe Kubosch"]
  s.date = "2015-05-31"
  s.description = "Beautiful graphs for one or multiple datasets. Can be used on websites or in documents."
  s.email = "boss@topfunky.com"
  s.homepage = "https://github.com/topfunky/gruff"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "Beautiful graphs for one or multiple datasets."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rmagick>, [">= 2.13.4"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
    else
      s.add_dependency(%q<rmagick>, [">= 2.13.4"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
    end
  else
    s.add_dependency(%q<rmagick>, [">= 2.13.4"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
  end
end
