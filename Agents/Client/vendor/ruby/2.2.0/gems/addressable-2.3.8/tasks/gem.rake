require "rubygems/package_task"

namespace :gem do
  GEM_SPEC = Gem::Specification.new do |s|
    s.name = PKG_NAME
    s.version = PKG_VERSION
    s.summary = PKG_SUMMARY
    s.description = PKG_DESCRIPTION

    s.files = PKG_FILES.to_a

    s.has_rdoc = true
    s.extra_rdoc_files = %w( CALLGIRL-README.md )
    s.rdoc_options.concat ["--main",  "CALLGIRL-README.md"]

    if !s.respond_to?(:add_development_dependency)
      puts "Cannot build Gem with this version of RubyGems."
      exit(1)
    end

    s.add_development_dependency 'rake', '~> 10.4', '>= 10.4.2'
    s.add_development_dependency 'rspec', '~> 3.0'
    s.add_development_dependency 'rspec-its', '~> 1.1'
    s.add_development_dependency 'launchy', '~> 2.4', '>= 2.4.3'

    s.require_path = "lib"

    s.author = "Bob Aman"
    s.email = "bob@sporkmonger.com"
    s.homepage = "https://github.com/sporkmonger/addressable"
    s.license = "Apache License 2.0"
  end

  Gem::PackageTask.new(GEM_SPEC) do |p|
    p.gem_spec = GEM_SPEC
    p.need_tar = true
    p.need_zip = true
  end

  desc "Generates .gemspec file"
  task :gemspec do
    spec_string = GEM_SPEC.to_ruby

    begin
      Thread.new { eval("$SAFE = 3\n#{spec_string}", binding) }.join
    rescue
      abort "unsafe gemspec: #{$!}"
    else
      File.open("#{GEM_SPEC.name}.gemspec", 'w') do |file|
        file.write spec_string
      end
    end
  end

  desc "Show information about the gem"
  task :debug do
    puts GEM_SPEC.to_ruby
  end

  desc "Install the gem"
  task :install => ["clobber", "gem:package"] do
    sh "#{SUDO} gem install --local pkg/#{GEM_SPEC.full_name}"
  end

  desc "Uninstall the gem"
  task :uninstall do
    installed_list = Gem.source_index.find_name(PKG_NAME)
    if installed_list &&
        (installed_list.collect { |s| s.version.to_s}.include?(PKG_VERSION))
      sh(
        "#{SUDO} gem uninstall --version '#{PKG_VERSION}' " +
        "--ignore-dependencies --executables #{PKG_NAME}"
      )
    end
  end

  desc "Reinstall the gem"
  task :reinstall => [:uninstall, :install]

  desc 'Package for release'
  task :release => ["gem:package", "gem:gemspec"] do |t|
    v = ENV['VERSION'] or abort 'Must supply VERSION=x.y.z'
    abort "Versions don't match #{v} vs #{PROJ.version}" if v != PKG_VERSION
    pkg = "pkg/#{GEM_SPEC.full_name}"

    changelog = File.open("CHANGELOG.md") { |file| file.read }

    puts "Releasing #{PKG_NAME} v. #{PKG_VERSION}"
    Rake::Task["git:tag:create"].invoke
  end
end

desc "Alias to gem:package"
task "gem" => "gem:package"

task "gem:release" => "gem:gemspec"

task "clobber" => ["gem:clobber_package"]
