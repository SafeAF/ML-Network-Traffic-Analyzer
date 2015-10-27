# -*- encoding: utf-8 -*-
# stub: ruby-pinyin 0.4.7 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-pinyin"
  s.version = "0.4.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Xie"]
  s.date = "2015-09-06"
  s.description = "Pinyin is a romanization system (phonemic notation) of Chinese characters, this gem helps you to convert Chinese characters into pinyin form."
  s.email = ["jan.h.xie@gmail.com"]
  s.homepage = "https://github.com/janx/ruby-pinyin"
  s.licenses = ["BSD"]
  s.rubygems_version = "2.4.8"
  s.summary = "Convert Chinese characters into pinyin."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rmmseg-cpp>, ["~> 0.2"])
      s.add_development_dependency(%q<minitest>, ["~> 5.4"])
    else
      s.add_dependency(%q<rmmseg-cpp>, ["~> 0.2"])
      s.add_dependency(%q<minitest>, ["~> 5.4"])
    end
  else
    s.add_dependency(%q<rmmseg-cpp>, ["~> 0.2"])
    s.add_dependency(%q<minitest>, ["~> 5.4"])
  end
end
