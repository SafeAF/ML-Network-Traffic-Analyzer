# -*- encoding: utf-8 -*-
# stub: stackprof 0.2.7 ruby lib
# stub: ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "stackprof"
  s.version = "0.2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Aman Gupta"]
  s.date = "2014-06-17"
  s.description = "stackprof is a fast sampling profiler for ruby code, with cpu, wallclock and object allocation samplers."
  s.email = "aman@tmm1.net"
  s.executables = ["stackprof", "stackprof-flamegraph.pl", "stackprof-gprof2dot.py"]
  s.extensions = ["ext/extconf.rb"]
  s.files = ["bin/stackprof", "bin/stackprof-flamegraph.pl", "bin/stackprof-gprof2dot.py", "ext/extconf.rb"]
  s.homepage = "http://github.com/tmm1/stackprof"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "sampling callstack-profiler for ruby 2.1+"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.9"])
      s.add_development_dependency(%q<mocha>, ["~> 0.14"])
    else
      s.add_dependency(%q<rake-compiler>, ["~> 0.9"])
      s.add_dependency(%q<mocha>, ["~> 0.14"])
    end
  else
    s.add_dependency(%q<rake-compiler>, ["~> 0.9"])
    s.add_dependency(%q<mocha>, ["~> 0.14"])
  end
end
