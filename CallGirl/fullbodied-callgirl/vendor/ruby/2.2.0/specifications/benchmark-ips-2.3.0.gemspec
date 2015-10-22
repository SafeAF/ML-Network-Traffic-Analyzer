# -*- encoding: utf-8 -*-
# stub: benchmark-ips 2.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "benchmark-ips"
  s.version = "2.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Evan Phoenix"]
  s.date = "2015-07-20"
  s.description = "A iterations per second enhancement to Benchmark."
  s.email = ["evan@phx.io"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.md"]
  s.files = ["History.txt", "Manifest.txt", "README.md"]
  s.homepage = "https://github.com/evanphx/benchmark-ips"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.rubygems_version = "2.4.6"
  s.summary = "A iterations per second enhancement to Benchmark."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<minitest>, ["~> 5.6"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.13"])
    else
      s.add_dependency(%q<minitest>, ["~> 5.6"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe>, ["~> 3.13"])
    end
  else
    s.add_dependency(%q<minitest>, ["~> 5.6"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe>, ["~> 3.13"])
  end
end
