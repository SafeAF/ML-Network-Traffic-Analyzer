# -*- encoding: utf-8 -*-
# stub: msgpack_rails 0.4.2 ruby lib

Gem::Specification.new do |s|
  s.name = "msgpack_rails"
  s.version = "0.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jingwen Owen Ou"]
  s.date = "2014-07-03"
  s.description = "Message Pack for Rails."
  s.email = ["jingweno@gmail.com"]
  s.homepage = "https://github.com/jingweno/msgpack_rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "The Rails way to serialize/deserialize with Message Pack."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0"])
      s.add_runtime_dependency(%q<msgpack>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["~> 10.3.1"])
      s.add_development_dependency(%q<minitest>, ["~> 5.3.3"])
      s.add_development_dependency(%q<activemodel>, ["~> 4.1.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.0"])
      s.add_dependency(%q<msgpack>, [">= 0"])
      s.add_dependency(%q<rake>, ["~> 10.3.1"])
      s.add_dependency(%q<minitest>, ["~> 5.3.3"])
      s.add_dependency(%q<activemodel>, ["~> 4.1.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.0"])
    s.add_dependency(%q<msgpack>, [">= 0"])
    s.add_dependency(%q<rake>, ["~> 10.3.1"])
    s.add_dependency(%q<minitest>, ["~> 5.3.3"])
    s.add_dependency(%q<activemodel>, ["~> 4.1.0"])
  end
end
