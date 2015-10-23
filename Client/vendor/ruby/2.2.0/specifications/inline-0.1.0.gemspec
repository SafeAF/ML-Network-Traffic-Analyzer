# -*- encoding: utf-8 -*-
# stub: inline 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "inline"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Fabio Cevasco"]
  s.date = "2008-03-14"
  s.description = "InLine can be used to define custom key bindings, perform common line editing operations, manage command history and define custom command completion rules."
  s.email = "h3rald@h3rald.com"
  s.extra_rdoc_files = ["README", "LICENSE", "CHANGELOG"]
  s.files = ["CHANGELOG", "LICENSE", "README"]
  s.homepage = "http://rubyforge.org/projects/inline"
  s.rdoc_options = ["--main", "README", "--exclude", "test"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = "inline"
  s.rubygems_version = "2.4.6"
  s.summary = "A library for definign custom key bindings and perform line editing operations"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<highline>, [">= 1.4.0"])
    else
      s.add_dependency(%q<highline>, [">= 1.4.0"])
    end
  else
    s.add_dependency(%q<highline>, [">= 1.4.0"])
  end
end
