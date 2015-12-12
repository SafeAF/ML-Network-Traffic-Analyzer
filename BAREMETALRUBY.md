# BareMetal Ruby And Ruby At BareMetal


# Installing Ruby

curl -L get.rvm.io | bash -s stable --rails

# Current Master Version List

+ Ruby-2.2.1
+ Rails-4.2.x
+ Jruby 1.x
+ RVM (Latest stable from get.rvm.io)


# Writing BareMetal Apps With <3Ruby

For rails apps, follow the standard directory structure, people expect it. Because they expect it they will be able to find particular code chunks when they need to with relative ease.

For non-rails apps


## Rake

Rake comes bundled with a few off the shelf tasks comprised of

Rake::GemPackageTask 
Rake::PackageTask
Rake::RDocTask
Rake::TestTask

Rake::TestTask.new do |t|
t.libs << 'lib'
t.pattern = 'test/*.test.rb'
test.verbose = false

## Style Guide
+ 2 space indendations, not 4



+ Use StringIO to Concat Large Amounts of Text Together vs Append with \n
__Bad__


       s = ''
       s << "\n" << "some text on a new line"
       s << "\nthis is pretty awkward"
       s = "#{s}\neven more ugly!"

__Good__

      s = StringIO.open do |s|
        s.puts 'adding newlines with puts is easy...'
        s.puts 'and simple'
        s.string
      end

## Gotchas to Look Out for and/or Guard Against

+ if you use any Unicode characters in your Ruby source files then you need to add

      # encoding: utf-8



# Ruby Syntax

# Beginning Ruby

# Intermediate Ruby

# Advanced Ruby

# Mind Melting Ruby

# Psychedelic Cloud Castles 

## Depracations to take note of in ruby >2.0.0

    Dir.exists? is a deprecated name, use Dir.exist? instead
    Enumerator.new without a block is deprecated; use Object#to_enum
    StringIO#bytes is deprecated; use StringIO#each_byte instead
    StringIO#chars is deprecated; use StringIO#each_char instead
    StringIO#codepoints is deprecated; use StringIO#each_codepoint instead
    StringIO#lines is deprecated; use StringIO#each_line instead
    File.exists? is a deprecated name, use File.exist? instead
    Hash#index is deprecated; use Hash#key
    ENV.index is deprecated; use ENV.key
    IO#lines is deprecated; use IO#each_line instead
    IO#bytes is deprecated; use IO#each_byte instead
    IO#chars is deprecated; use IO#each_char instead
    IO#codepoints is deprecated; use IO#each_codepoint instead
    ARGF#lines is deprecated; use ARGF#each_line instead
    ARGF#bytes is deprecated; use ARGF#each_byte instead
    ARGF#chars is deprecated; use ARGF#each_char instead
    ARGF#codepoints is deprecated; use ARGF#each_codepoint instead
    Object#untrusted? is deprecated and its behavior is same as Object#tainted?
    Object#untrust is deprecated and its behavior is same as Object#taint
    Object#trust is deprecated and its behavior is same as Object#untaint
    passing a block to String#lines is deprecated
    passing a block to String#bytes is deprecated
    passing a block to String#chars is deprecated
    passing a block to String#codepoints is deprecated

