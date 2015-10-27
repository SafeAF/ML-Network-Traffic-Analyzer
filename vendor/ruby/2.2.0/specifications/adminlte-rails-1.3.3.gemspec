# -*- encoding: utf-8 -*-
# stub: adminlte-rails 1.3.3 ruby lib

Gem::Specification.new do |s|
  s.name = "adminlte-rails"
  s.version = "1.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nguyen Ba Dung"]
  s.date = "2014-09-17"
  s.description = "AdminLTE is a premium Bootstrap theme for Backend."
  s.email = ["nguyenbadung@gmail.com"]
  s.homepage = "https://github.com/shine60vn/adminlte-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Integrates the AdminLTE theme with the Rails asset pipeline"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thor>, ["~> 0.14"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<rails>, [">= 3.0"])
      s.add_development_dependency(%q<httpclient>, ["~> 2.2"])
      s.add_development_dependency(%q<byebug>, [">= 0"])
    else
      s.add_dependency(%q<thor>, ["~> 0.14"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<rails>, [">= 3.0"])
      s.add_dependency(%q<httpclient>, ["~> 2.2"])
      s.add_dependency(%q<byebug>, [">= 0"])
    end
  else
    s.add_dependency(%q<thor>, ["~> 0.14"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<rails>, [">= 3.0"])
    s.add_dependency(%q<httpclient>, ["~> 2.2"])
    s.add_dependency(%q<byebug>, [">= 0"])
  end
end
