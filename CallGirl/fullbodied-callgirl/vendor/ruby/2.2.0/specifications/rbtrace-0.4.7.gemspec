# -*- encoding: utf-8 -*-
# stub: rbtrace 0.4.7 ruby lib
# stub: ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "rbtrace"
  s.version = "0.4.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Aman Gupta"]
  s.date = "2015-02-13"
  s.description = "rbtrace shows you method calls happening inside another ruby process in real time."
  s.email = "aman@tmm1.net"
  s.executables = ["rbtrace"]
  s.extensions = ["ext/extconf.rb"]
  s.files = ["bin/rbtrace", "ext/extconf.rb"]
  s.homepage = "http://github.com/tmm1/rbtrace"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "rbtrace: like strace but for ruby code"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 1.0.6"])
      s.add_runtime_dependency(%q<trollop>, [">= 1.16.2"])
      s.add_runtime_dependency(%q<msgpack>, [">= 0.4.3"])
    else
      s.add_dependency(%q<ffi>, [">= 1.0.6"])
      s.add_dependency(%q<trollop>, [">= 1.16.2"])
      s.add_dependency(%q<msgpack>, [">= 0.4.3"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 1.0.6"])
    s.add_dependency(%q<trollop>, [">= 1.16.2"])
    s.add_dependency(%q<msgpack>, [">= 0.4.3"])
  end
end
