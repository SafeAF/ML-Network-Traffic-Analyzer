# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ruby-fann"
  s.version = "1.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["tangledpath"]
  s.date = "2013-11-17"
  s.description = "Bindings to use FANN from within ruby/rails environment"
  s.email = ["steven.miers@gmail.com"]
  s.extensions = ["ext/ruby_fann/extconf.rb"]
  s.extra_rdoc_files = ["README.md", "ext/ruby_fann/ruby_fann.c"]
  s.files = ["README.md", "ext/ruby_fann/ruby_fann.c", "ext/ruby_fann/extconf.rb"]
  s.homepage = "http://github.com/tangledpath/ruby-fann"
  s.require_paths = ["lib", "ext"]
  s.rubyforge_project = "ruby-fann"
  s.rubygems_version = "1.8.23"
  s.summary = "Bindings to use FANN from within ruby/rails environment.  Fann is a is a free open source neural network library, which implements multilayer artificial neural networks with support for both fully connected and sparsely connected networks.  It is easy to use, versatile, well documented, and fast.  RubyFann makes working with neural networks a breeze using ruby, with the added benefit that most of the heavy lifting is done natively."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
