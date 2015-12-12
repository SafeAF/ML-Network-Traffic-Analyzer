# -*- encoding: utf-8 -*-
# stub: highcharts 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "highcharts"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Nick Willever"]
  s.date = "2012-02-20"
  s.description = "This allows you to extend the charting module into your classes and then use it to create json for highcharts"
  s.email = ["nickwillever@gmail.com"]
  s.homepage = ""
  s.rubygems_version = "2.4.6"
  s.summary = "Provides an extendable class for charting with high charts"

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ice_cube>, ["= 0.7.7"])
    else
      s.add_dependency(%q<ice_cube>, ["= 0.7.7"])
    end
  else
    s.add_dependency(%q<ice_cube>, ["= 0.7.7"])
  end
end
