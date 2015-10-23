# -*- encoding: utf-8 -*-
# stub: irb-benchmark 0.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "irb-benchmark"
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Maurizio De Santis"]
  s.date = "2014-02-26"
  s.description = "irb-benchmark wraps irb commands in a Benchmark.measure{ ... } block and displays \nthe results after the command execution"
  s.email = "desantis.maurizio@gmail.com"
  s.extra_rdoc_files = ["LICENSE.txt", "README.md"]
  s.files = ["LICENSE.txt", "README.md"]
  s.homepage = "http://github.com/mdesantis/irb-benchmark"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "irb commands auto-benchmarking"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
    else
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    end
  else
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
  end
end
