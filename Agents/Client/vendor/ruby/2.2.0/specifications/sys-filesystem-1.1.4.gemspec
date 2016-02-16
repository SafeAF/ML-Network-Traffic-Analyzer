# -*- encoding: utf-8 -*-
# stub: sys-filesystem 1.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "sys-filesystem"
  s.version = "1.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Daniel J. Berger"]
  s.date = "2015-03-15"
  s.description = "    The sys-filesystem library provides a cross-platform interface for\n    gathering filesystem information, such as disk space and mount point data.\n"
  s.email = "djberg96@gmail.com"
  s.extra_rdoc_files = ["CHANGES", "README", "MANIFEST"]
  s.files = ["CHANGES", "MANIFEST", "README"]
  s.homepage = "https://github.com/djberg96/sys-filesystem"
  s.licenses = ["Artistic 2.0"]
  s.rubyforge_project = "sysutils"
  s.rubygems_version = "2.4.6"
  s.summary = "A Ruby interface for getting file system information."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 2.5.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<ffi>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 2.5.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 2.5.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
