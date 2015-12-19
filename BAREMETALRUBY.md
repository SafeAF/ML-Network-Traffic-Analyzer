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

## Modifying Paths for i.e. Loading Files


+ ROOT = File.join(File.dirname(__FILE__), '..')


+ ['../app/models/' '../lib', '../db'].each { |f| $:.unshift File.join(ROOT, folder) }


+ BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..'); $:.unshift File.join(BASE_PATH, 'lib')


+ Dir[File.dirname(__FILE__) + '../lib*.rb'].each { |file| require File.basename(file, File.extname(file)) }


# Advanced Ruby

# Mind Melting Ruby

# Psychedelic Cloud Castles 

__Debugging Ruby Processes with GDB__

 Ruby processes are just regular processes. They can be debugged with gdb.

              define redirect_stdout
                call rb_eval_string("$_old_stdout, $stdout = $stdout,
                  File.open('/tmp/ruby-debug.' + Process.pid.to_s, 'a'); $stdout.sync = true")
              end

              define ruby_eval
                call(rb_p(rb_eval_string_protect($arg0,(int*)0)))
              end

How to use these:

    Start up gdb by running gdb /path/to/ruby PID, where /path/to/ruby is the full path to the actual ruby binary and PID is the process ID of the ruby you want to check out.
    Paste those functions above into the gdb prompt (you might also want to store them in ~/.gdbinit for later).
    Run redirect_stdout, which will put all the ruby output into a file called /tmp/ruby-debug.PID where PID in this case if the process id of gdb – not terribly important, but a differentiator in case you do this a lot.
    Run commands via ruby_eval('Kernel.caller') and object_id and things like that. You should be able to get local variables from wherever you broke into the program.

These ruby_eval commands will output into the tempfile that redirect_stdout created, so you’ll need to tail -f that file in a different console. Now, with that small headache over with, you can see exactly where your program is and if there is a stupid loop where you forgot to check a boundary condition, or what thing you’re doing with a regular expression on where you should have just used String#index.


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

