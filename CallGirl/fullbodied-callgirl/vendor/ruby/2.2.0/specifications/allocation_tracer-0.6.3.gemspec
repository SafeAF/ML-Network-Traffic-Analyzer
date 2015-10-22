# -*- encoding: utf-8 -*-
# stub: allocation_tracer 0.6.3 ruby lib
# stub: ext/allocation_tracer/extconf.rb

Gem::Specification.new do |s|
  s.name = "allocation_tracer"
  s.version = "0.6.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Koichi Sasada"]
  s.date = "2015-04-18"
  s.description = "allocation_tracer gem adds ObjectSpace::AllocationTracer module."
  s.email = ["ko1@atdot.net"]
  s.extensions = ["ext/allocation_tracer/extconf.rb"]
  s.files = ["ext/allocation_tracer/extconf.rb"]
  s.homepage = "https://github.com/ko1/allocation_tracer"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0")
  s.rubygems_version = "2.4.6"
  s.summary = "allocation_tracer gem adds ObjectSpace::AllocationTracer module."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rake-compiler>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rake-compiler>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rake-compiler>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
