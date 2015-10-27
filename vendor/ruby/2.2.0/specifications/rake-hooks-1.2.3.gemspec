# -*- encoding: utf-8 -*-
# stub: rake-hooks 1.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rake-hooks"
  s.version = "1.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Guillermo \u{c1}lvarez", "Joel Moss"]
  s.date = "2011-12-01"
  s.description = "Add after and before hooks to rake tasks. You can use \"after :task do ... end\" and \"before :task do ... end\"."
  s.email = ["guillermo@cientifico.net", "joel@developwithstyle.com"]
  s.rubyforge_project = "rake-hooks"
  s.rubygems_version = "2.4.8"
  s.summary = "Add after and before hooks to rake tasks"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
  end
end
