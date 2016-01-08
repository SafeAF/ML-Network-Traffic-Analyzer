# -*- encoding: utf-8 -*-
# stub: sysinfo 0.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "sysinfo"
  s.version = "0.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Delano Mandelbaum"]
  s.date = "2014-02-13"
  s.description = "SysInfo: All your system-independent infoz in one handy class."
  s.email = "delano@solutious.com"
  s.executables = ["sysinfo"]
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.files = ["LICENSE.txt", "README.rdoc", "bin/sysinfo"]
  s.homepage = "http://solutious.com/"
  s.rdoc_options = ["--line-numbers", "--title", "SysInfo: All your system-independent infoz in one handy class.", "--main", "README.rdoc"]
  s.rubyforge_project = "sysinfo"
  s.rubygems_version = "2.4.6"
  s.summary = "SysInfo: All your system-independent infoz in one handy class."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<storable>, [">= 0"])
      s.add_runtime_dependency(%q<drydock>, [">= 0"])
    else
      s.add_dependency(%q<storable>, [">= 0"])
      s.add_dependency(%q<drydock>, [">= 0"])
    end
  else
    s.add_dependency(%q<storable>, [">= 0"])
    s.add_dependency(%q<drydock>, [">= 0"])
  end
end
