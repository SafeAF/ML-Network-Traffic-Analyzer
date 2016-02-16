#$:.push File.expand_path("../lib", __FILE__)

#require "riptables/version"

Gem::Specification.new do |s|
  s.name        = "kimberlite"
  s.version     = '0.5.0'
  s.authors     = ["SJK"]
  s.email       = ["support@baremetalnetworks.com"]
  s.homepage    = "http://baremetalnetworks.com"
  s.licenses    = ['PRIVATE']
  s.summary     = "Dashboard for Attrition"
  s.description = "Dashboard for Attrition"
  s.required_ruby_version = ">= 2.0", "< 3"
  s.bindir      = "bin"
  #s.executables << 'riptables'
  #s.files = Dir["{bin,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
end
