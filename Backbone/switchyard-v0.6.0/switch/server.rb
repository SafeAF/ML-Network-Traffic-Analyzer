=begin
#### SWITCHYARD SERVER ####
#### Copyright (C) 2010-2012 BareMetal Networks Corporation
=end
$VERSION = '0.7.1'
$DATE = '07/29/12'
require 'rubygems'
require 'webrick'
require 'webrick/https'
require 'drb'
require 'lib/post_operations.rb'
require 'lib/get_operations.rb'
require 'lib/error.rb'
require 'lib/core.rb'
require 'lib/monkey_patch.rb'
require 'pry'

# rvm use '1.9.3'

### Required for ActiveRecord magick -- Include ALL models
### Don't forget to include app/models/user from kimberlite to 
### lend user model and authorize functions
require 'active_record'
require 'sqlite3'
require '../kimberlite/app/models/user'
require '../kimberlite/app/models/machine'
require '../kimberlite/app/models/instance'

### More AR juice
ROOT = File.join(File.dirname(__FILE__), '..')
  
['/lib', '/db'].each do |folder|
 $:.unshift File.join(ROOT, folder)
end
      
#ActiveRecord::Base.logger = Logger.new('log/emergence_dbi_debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('../kimberlite/config/database.yml'))
ActiveRecord::Base.establish_connection('development')

## 700 is switchyard return code space

#### WEBRICK SERVER ####

if $0 == __FILE__ then
p "[+] Starting Distrubted Ruby Service"
DRb.start_service
$apache_mod = DRbObject.new nil, 'druby://localhost:11000'
p "[+] Training the Neural Network..."
$apache_mod.train_nn
p "[+] Training complete"

ROOT = Dir.getwd
options = {
  :port         => "7000",
  :ip           => "0.0.0.0",
  :environment  => (ENV['RAILS_ENV'] || "development").dup,
  :server_root  => File.expand_path(ROOT + "/public/"),
#  :pkey         => OpenSSL::PKey::RSA.new(
#                      File.open(ROOT + "/config/certs/server.key").read),
#  :cert         => OpenSSL::X509::Certificate.new(
#                      File.open(ROOT + "/config/certs/server.crt").read),
  :server_type  => WEBrick::SimpleServer,
  :charset      => "UTF-8",
  :mime_types   => WEBrick::HTTPUtils::DefaultMimeTypes,
  :debugger     => false
}

#ENV["RAILS_ENV"] = OPTIONS[:environment]
#RAILS_ENV.replace(OPTIONS[:environment]) if defined?(RAILS_ENV)

  server = WEBrick::HTTPServer.new(
      :Port             => options[:port].to_i,
      :ServerType       => options[:server_type],
      :BindAddress      => options[:ip],
      :SSLEnable        => true,
      :SSLVerifyClient  => OpenSSL::SSL::VERIFY_NONE,
      :SSLCertificate   => options[:cert],
      :SSLPrivateKey    => options[:pkey],
      :SSLCertName      => [ [ "CN", WEBrick::Utils::getservername ] ]

    )



server.mount "/submit", HandlePost, options
server.mount "/retrieve", HandleGet, options
server.mount "/chkupdate", CheckUpdate, options
server.mount "/getbans", GetBans, options

print "\n"
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
puts "   Emergence Switchyard Server v #{$VERSION}..."  
puts "   Build Date #{$DATE}"
puts "   Copyright (C) 2010-2012 BareMetal Networks Corporation"
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
print "\n"
trap "INT" do server.shutdown end

#console = Thread.new {
#	binding.pry
#	}
server.start
#binding.pry
end

 
