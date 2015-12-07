# Testing Procedures & Processes


## Adding Cucumber to Project
File layout

    Everything cucumber should live in features directory.
    Features describing your project live in this features directory
    features/support/env.rb sets up the world that the features will be run under
    Steps live in the features/step_definitions directory

Here’s some convient bash one-liner for making the directories:

mkdir -p features/{support,step_definitions}

env.rb

You do have one choice to make here… what framework do you want to use implement your steps? The wiki has instructions for using Test::Unit, MiniTest, and RSpec.

It’s also worth noting that env.rb is the cucumber-equivalent of test_helper.rb or spec_helper.rb, so do any configuration or requireing here. For example you probably want to require your main ruby file from the lib directory. For jeweler, I did:

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'jeweler'

Rake configuration

You do have a Rakefile, right? Given the file layout above, you can add this snippet:

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  puts "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
end

Summary

Adding cucumber to a project is pretty straightforward, but all the info was never in one place. Hopefully, this article addresses that. Now you can have fun writing your features and step definitions.
