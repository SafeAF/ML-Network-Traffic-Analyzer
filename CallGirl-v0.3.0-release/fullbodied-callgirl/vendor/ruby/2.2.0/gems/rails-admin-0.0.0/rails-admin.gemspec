# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|

  s.name = "rails-admin"
  s.version = "0.0.0"
  s.platform = Gem::Platform::RUBY
  s.authors = ["Francesc Esplugas"]
  s.email = ["francesc@intraducibles.com"]
  s.homepage = "http://www.railsadmin.org/"
  s.summary = ""
  s.description = ""

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = "rails-admin"

  s.files = Dir.glob("**/*")
  s.require_path = "lib"

end