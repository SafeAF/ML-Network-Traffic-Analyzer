#!/usr/bin/env ruby

$LOAD_PATH[0, 0] = File.join(File.dirname(__FILE__), '..', 'lib')
require 'pry'
require 'mongo'

# include the mongo namespace
include Mongo

Pry.config.prompt_name = 'mongo> '
Pry.start