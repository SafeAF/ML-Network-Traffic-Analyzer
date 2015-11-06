=begin
##################################################################
#### ADAPTIVE DEFENSE INFRASTRUCTURE -- ADI v0.2.0 10-23-15   ####
#### SWITCHDEMO  MIDDLEWARE                                   ####
#### Copyright (C) 2010-2015 BareMetal Networks Corporation   ####
##################################################################

###############################################################################
#### Switchyard is the API of Emergence and the only component that is exposed
#### to the internet, client daemons connect and upload logfiles and download
#### configurations and ban lists
###############################################################################
=end

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')

$VERSION = '0.2.1'
$DATE = '07/15/15'
require 'rubygems'
require 'thin'
require 'rack'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'logger'
require 'sinatra/base'
require 'connection_pool'
require 'active_record'
require 'mysql2'
require 'pp'

#### TODO
# message pack
# api key/pw

#### Installation
## apt-get install libmyslclient18 libmysqlclient18-dev
## Gem install mysql2
## gem install hiredis

ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
  $:.unshift File.join(ROOT, folder)
end

p "######################## ADI ##########################"
p "#          ADAPTIVE DEFENSE INFRASTRUCTURE            #"
p "#######################################################"
p "##########  Switchyard RESTful API Server  ############"
p "#######################################################"
p "#v#{$VERSION} Codename: She's Thin, With A Great Rack!#"
p "#######################################################"

p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Middleware: #{File.basename(__FILE__)}"
# Use jruby with threaded servers, possible even not because its great at long running apps
# Benchmark everything


### Required for ActiveRecord magick -- Include ALL models
### Don't forget to include app/models/user from kimberlite to
### lend user model and authorize functions
# require '../app/models/instance.rb'
# require '../app/models/user.rb'
# require '../app/models/machine.rb'
# rvm use '1.9.3'


$logger = Logger.new('switchyard.log', 'w')

$options = Hash.new
$options[:host] = 'localhost'# '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5
#if ARGV[1].? '--db-config'
#ActiveRecord::Base.$logger = Logger.new('log/db.log')
#ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))
#end
ActiveRecord::Base.logger = Logger.new('db.log')
#ActiveRecord::Base.establish_connection(:development)
begin
  ActiveRecord::Base.establish_connection(
      :adapter => 'mysql2',
      :database => 'emergence',
      :username => 'emergence',
      :password => '#GDU3im=86jDFAipJ(f7*rTKuc',
      :host => 'datastore2',
      :timeout => 1000,
      :pool => 5)
rescue => err
  ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
  :database => 'emergence.db',
      :timeout => 1000,
      :pool => 5)
end

Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('e:switchyard', :marshall => true)

$TITLE = 'Emergence'


class SwitchyardSSH
def initialize
# Notes:
#
#   "Failed \S+ for .*? from <HOST>..." failregex uses non-greedy catch-all because
#   it is coming before use of <HOST> which is not hard-anchored at the end as well,
#   and later catch-all's could contain user-provided input, which need to be greedily
#   matched away first.
## Borrowed from Authors: Cyril Jaquier, Yaroslav Halchenko, Petr Voralek, Daniel Black

failregex =[
%q{^%(__prefix_line)s(?:error: PAM: )?[aA]uthentication (?:failure|error) for .* from <HOST>( via \S+)?\s*$},
 %q{^%(__prefix_line)s(?:error: PAM: )?User not known to the underlying authentication module for .* from <HOST>\s*$},
 %q{^%(__prefx_line)sFailed \S+ for .*? from <HOST>(?: port \d*)?(?: ssh\d*)?(: (ruser .*|(\S+ ID \S+ \(serial \d+\) CA )?\S+ %(__md5hex)s(, client user ".*", client host ".*")?))?\s*$},
 %q{ ^%(__prefix_line)sROOT LOGIN REFUSED.* FROM <HOST>\s*$},
 %q{    ^%(__prefix_line)s[iI](?:llegal|nvalid) user .* from <HOST>\s*$},
 %q{ ^%(__prefix_line)sUser .+ from <HOST> not allowed because not listed in AllowUsers\s*$},
 %q{^%(__prefix_line)sUser .+ from <HOST> not allowed because listed in DenyUsers\s*$} ,
 %q{^%(__prefix_line)sUser .+ from <HOST> not allowed because not in any group\s*$} ,
 %q{ ^%(__prefix_line)srefused connect from \S+ \(<HOST>\)\s*$},
 %q{ ^%(__prefix_line)sUser .+ from <HOST> not allowed because a group is listed in DenyGroups\s*$},
 %q{^%(__prefix_line)sUser .+ from <HOST> not allowed because none of user's groups are listed in AllowGroups\s*$},
    ]
  end
end

class SwitchyardAPI < Sinatra::Base
  #attr_reader :user_obj

  def initialize
    p "#{Time.now}:#{self.class}:IP##{__LINE__} Handling request: RESTFUL API: Class #{self.class}" if $DBG
  end

  def demo(request)
	  query = request.query

	  if query
		  pcap = query[:pcap_log] if query[:pcap_log]
		  #pcap_inputs = pcap.split("\n")
		  pcap_inputs = JSON.parse(pcap) ## look into using message pack ehre
		  logs = query[:log] if query[:log]

		  pcap_inputs.each do |packet|
			  header, features = packet.split("~~")
			  features_str = features.to_s
			  red = Hash.new
			  red[:time], red[:src], red[:dst], red[:sport], red[:dport] = header.split('::')
			  red[:features] = features_str
			  $logger.info "#{Time.now} - Pushing packet SRC:#{red[:src]}:#{red[:sport]}
DST:#{red[:dst]}:#{red[:dport]}"
			  $SHM.push(red)
		  end
	  end
  end


  def handle_log_submit(request)
    query = request.query## FIXME
    gucid = params[:gucid]
    cid = params[:cid]

    ret = ''
    # dont post if gucid of default
    return post_err[:default] if gucid.is_default?

    if machine = @user_obj.machines.find_by_cid(cid)

      if instance = machine.instances.find_by_gucid(gucid)

        return not_subbed_err if instance.subscribed == false

        blood_inputs = []
        pcap = query['pcap_log'] # FIXME
        pcap_inputs = pcap.split("\n")

        result = case query[:instance_type]
                   when /SSH/i then
                     $ssh_module_result = ''
                     Thread.new{
                      ssh = SwitchyardSSH.new()
                      if ssh.parse
                        Ban.new(query[:src], :reason => ssh.parse)
                      end
                     }
                     #p post_err[:no_mod] + ' ' + result
                  #   return 200, "text/plain", 'Success'

                   when /APACHE/i then
                   # begin
                     blood_inputs = []
                     pcap = query[:pcap_log] if query[:pcap_log]
                     #pcap_inputs = pcap.split("\n")
                     pcap_inputs = JSON.parse(pcap)
                     logs = query[:log] if query[:log]

                     pcap_inputs.each do |packet|
	                     #header, features = packet.split("~~~")
                       header, features = packet.split("~~")
                       features_str = features.to_s
                       red = Hash.new
                       red[:time], red[:src], red[:dst], red[:sport], red[:dport] = header.split('::')
                       red[:features] = features_str
                       $logger.info "#{Time.now} - Pushing packet SRC:#{red[:src]}:#{red[:sport]}
DST:#{red[:dst]}:#{red[:dport]}"
                       $SHM.push(red)
                  #     return 200, "text/plain", 'Success'

                     #   rescue => err
                     #   $logger.error "#{Time.now} - Error in Apache module #{err.inspect}"
                     # end
                     #
                    end

                   else
                     $logger.warn("Bad submission from #{query[:gucid]} cid: #{query[:cid]}")

                 end
      else
        return no_subs_found_err('foo')
      end
    else
      return create_a_machine_err
    end
  end

  #  return 200, "text/plain", response
  def get_bans
    bans = Ban.find(:all, :conditions =>
                            ["last_seen > ?", (Time.now - (60 * 60 * 24)).to_s])

  end

  def check_update_flag(request)
    cid = request[:cid] || params[:cid]
    gucid = request[:gucid] || params[:cid]
    update_flag = 0

    unless gucid.include? 'default'
      machine = @user_obj.machines.find_by_cid(cid)

      if machine
        instance = machine.instances.find_by_gucid(gucid)
        if instance.conf.update_flag == 1
          update_flag = 1
          machine.just_seen(request.peeraddr[3])
          # FIXME: this is a hack
          instance.conf.update_flag = 0
        end
      else  # if no machine found with that cid


      end
      response = update_flag
    end

    return 200, "text/plain", response.to_s
  end

  ##########################################

  def get_bans
    bans = Ban.find(:all, :conditions =>
                            ["last_seen > ?", (Time.now - (60 * 60 * 24)).to_s])


  end

  def get_config(request, user_obj)
    cid = request[:cid]  || params[:cid]

    gucid = request[:gucid] || params[:cid]
    #	return invalid_cid_err unless cid.is_valid_cid?

    # machine found
    if machine = user_obj.machines.find_by_cid(cid)
      machine.just_seen(request.peeraddr[3])

      if gucid.is_default?

        if instance = machine.sub_instance_avail?
          instance.just_seen(request.peeraddr[3])
          return instance.return_conf_json

        else
          return no_subs_found_err(gucid)
        end

      elsif gucid.is_valid_gucid?

        if instance = machine.instances.find_by_gucid(gucid)
          return not_subbed_err if instance.subscribed == false
          instance.just_seen(request.peeraddr[3])
          return instance.return_conf_json
        end

      else
        return invalid_gucid_err(gucid)
      end

      #no machine found
    else
      if machine = @user_obj.machine_avail?
        machine.cid = cid
        machine.just_seen(request.peeraddr[3])

        if instance = machine.sub_instance_avail?
          instance.just_seen
          return instance.return_conf_json
        else
          return no_subs_found_err(gucid)
        end
      else
        return create_a_machine_err
      end
    end
  end
end

## 700 is switchyard return code space

begin
  ### Switchyard is the protected class
class Switchyard < Sinatra::Base
  attr_accessor :user_obj
  set :server, :thin
  set :environment, :production
  #before do ; expires 300, :public, :must_revalidate ;end # before filter use instead of in method, protip

  def initialize
  $logger.info "#{Time.now}:#{self.class}:IP##{__LINE__}: Received request"
  end

  get '/' do
    'Emergence API'
  end

  get '/config' do
    $DBG = false
    pp env if $DBG
    #cache_control :public; "cache it"
    ret = {}
    sw = SwitchyardAPI.new
    ret[:body] = sw.get_config(params, @user_obj)
    #if params.has_key?('gucid')foo
      #'Hey there'
    #  status, response = generate_response(params)
  #  if
    #end
  end

  post '/logs' do
    $DBG = false
    pp env if $DBG
    ret = {}
    sw = SwitchyardAPI.new
    ret[:body] = sw.handle_log_submit(request)
  end

  post '/check_update' do
    $DBG = false
    pp env if $DBG
    ret = {}
    sw = SwitchyardAPI.new
    ret[:body] = sw.check_update_flag(request)
  end

  def self.new(*)

    app = Rack::Auth::Digest::MD5.new(super) do |username, password|
      $logger.info "Authentication Request: #{username}:#{password}"
      {'foo'=> 'bar'}[username]

     # @user_obj = User.authenticate(username, password)
    end

    app.realm = "Emergence"
    app.opaque = "eikjalkjalosdfjSecret3pij398323543klhj2lh4tkth4858674"
    app
  end

end

rescue => err
  pp err.inspect
end




__END__

