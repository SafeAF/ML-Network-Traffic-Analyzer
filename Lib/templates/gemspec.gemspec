# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
## Require your version file
# sample version.rb file
#module Foo
#  module Bar
#    VERSION="0.0.1"
#  end;end

require 'foo/bar/version'
 
Gem::Specification.new do |s|
  s.name        = "foo-bar"
  s.version     = Foo::Bar::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Samuel Kerr"]
  s.email       = ["sam@baremetalnetworks.com"]
  s.summary     = "Sample description goes here"
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_dependency "rake"
 
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
end