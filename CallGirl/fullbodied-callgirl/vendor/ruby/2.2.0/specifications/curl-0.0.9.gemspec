# -*- encoding: utf-8 -*-
# stub: curl 0.0.9 ruby lib

Gem::Specification.new do |s|
  s.name = "curl"
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["tg0"]
  s.date = "2011-03-09"
  s.description = "Some simple methods to use shell curl"
  s.email = "email@tg0.ru"
  s.homepage = "http://github.com/tg0/curl"
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.rubyforge_project = "curl"
  s.rubygems_version = "2.4.6"
  s.summary = "shell CURL ruby wrapper."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<awesome_print>, [">= 0.2.1"])
      s.add_runtime_dependency(%q<unidecoder>, [">= 1.1.1"])
    else
      s.add_dependency(%q<awesome_print>, [">= 0.2.1"])
      s.add_dependency(%q<unidecoder>, [">= 1.1.1"])
    end
  else
    s.add_dependency(%q<awesome_print>, [">= 0.2.1"])
    s.add_dependency(%q<unidecoder>, [">= 1.1.1"])
  end
end
