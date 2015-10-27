# -*- encoding: utf-8 -*-
# stub: redis-search 0.9.7 ruby lib

Gem::Specification.new do |s|
  s.name = "redis-search"
  s.version = "0.9.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jason Lee"]
  s.date = "2014-10-08"
  s.description = "High performance real-time search (Support Chinese), indexes store in Redis for Rails applications. "
  s.email = ["huacnlee@gmail.com"]
  s.homepage = "http://github.com/huacnlee/redis-search"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "High performance real-time search (Support Chinese), indexes store in Redis for Rails applications."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-pinyin>, [">= 0.3.0", "~> 0.3"])
      s.add_runtime_dependency(%q<redis-namespace>, [">= 1.3.0"])
      s.add_runtime_dependency(%q<redis>, [">= 3.0.0"])
    else
      s.add_dependency(%q<ruby-pinyin>, [">= 0.3.0", "~> 0.3"])
      s.add_dependency(%q<redis-namespace>, [">= 1.3.0"])
      s.add_dependency(%q<redis>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<ruby-pinyin>, [">= 0.3.0", "~> 0.3"])
    s.add_dependency(%q<redis-namespace>, [">= 1.3.0"])
    s.add_dependency(%q<redis>, [">= 3.0.0"])
  end
end
