# -*- encoding: utf-8 -*-
# stub: ferret 0.11.8.6 ruby lib
# stub: ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "ferret"
  s.version = "0.11.8.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["David Balmain"]
  s.date = "2015-02-19"
  s.description = "Ferret is a super fast, highly configurable search library."
  s.email = "dbalmain@gmail.com"
  s.executables = ["ferret-browser"]
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["README", "TODO", "TUTORIAL", "MIT-LICENSE", "ext/r_analysis.c", "ext/r_index.c", "ext/r_qparser.c", "ext/r_search.c", "ext/r_store.c", "ext/r_utils.c", "ext/ferret.c"]
  s.files = ["MIT-LICENSE", "README", "TODO", "TUTORIAL", "bin/ferret-browser", "ext/extconf.rb", "ext/ferret.c", "ext/r_analysis.c", "ext/r_index.c", "ext/r_qparser.c", "ext/r_search.c", "ext/r_store.c", "ext/r_utils.c"]
  s.homepage = "http://github.com/jkraemer/ferret"
  s.rdoc_options = ["--title", "Ferret -- Ruby Search Library", "--main", "README", "--line-numbers", "TUTORIAL", "TODO"]
  s.rubyforge_project = "ferret"
  s.rubygems_version = "2.4.6"
  s.summary = "Ruby indexing library."

  s.installed_by_version = "2.4.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
