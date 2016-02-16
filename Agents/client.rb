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
## Notes ##
# use riptables from github for iptables support
# use threading and mutexes on attr tmpfiles etc
# use proper tempfile gem?
# TODO process log messages so that duplicates are not sent, record only # and time after first one

### INIT ###
require 'logger'
require 'net/http'
require 'inotify'
require 'json'
require 'rb-inotify'

$logger = Logger.new('client.log')


Dir[File.dirname(__FILE__) + '../lib*.rb'].each do |file|
  require File.basename(file, File.extname(file))
end
ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
  $:.unshift File.join(ROOT, folder)
end
## Core Fuctions ###

def submit_logfile(url, gucid, logfile=nil, pcapfile=nil)

  begin
    @uri = URI.parse(url)

    @http = Net::HTTP.new(@uri.host, @uri.port)
    @req = Net::HTTP::Post.new(@uri.path)
    #	@http.use_ssl = true
    @req.basic_auth $options[:user], $options[:pass]
    @req.set_form_data({
                           'user' => $options[:user],
                           'pass' => $options[:pass],
                           #				'instances_installed' => @instances.keys.join('--'),
                           'platform' => RUBY_PLATFORM,
                           'instance_type' => self.instance_type,
                           'hostname' => self.hostname,
                           'client_version' => $options[:version],
                           'gucid' => gucid,
                           'cid' => $options[:cid],

                           'log' => logfile,
                           'pcap_log' => pcapfile,
                       } )
    @response = @http.request(@req)
    return @response.body

  rescue Exception => err
    print "[#{Time.now}] Error: Exception #{err.inspect}"
    puts "[#{Time.now}] Error: Backtrace #{err.backtrace}"
    sleep $options[:retry]
    retry
  end
end

def truncate_log(location)
  return if location.nil?
  return if not File.exists? location
  if File.size(location) > 0
    log = File.open(location, 'w')
    log.truncate(0)
    log.close
  end
end

def monitor_logfile(filename)
  begin
    open(filename) do |file|
      file.read
      queue = INotify::Notifier.new
      queue.watch(filename, :modify) do
        yield file.read
      end
      queue.run
    end

  rescue => err
    $logger.error "[#{Time.now}]: Error #{err}"
  ensure
    "We have fun"
  end
end


loopStart = Time.now.to_i
targetLogfile = ARGV[0] || '/var/log/apache2/access.log'
$APIURL = ARGV[1] || 'http://10.0.1.223'
$APIURL += ':'
$APIURL += $PORT || '5000'
$APIURL += $API_LOG_UP_URL || '/logs/'
#api_url = 'http://' + $options[:host] + ':' + $options[:port]
#filename = '/home/vishnu/foo.txt'
#submit_logfile(api_url+"submit/", gucid, 'foo', 'bar' )

# spawn a seperate thread to send the log off, eventually seperate thread with locking to truncate tooaddu
instanceLogfile = StringIO.new

monitor_logfile targetLogfile do |data|

  p data
  begin
#    f = File.write(instance_logfile, data)
 #   f.flush
  #  File.close
    p data
    begin
      apiURL = $APIURL
      instanceLogfile << data # anything else we want to append?
      loopTimeCheck = Time.now.to_i
      if instanceLogfile.length > 0
        if (loopTimeCheck - loopStart) > $options[:send_delay]
          submit_logfile(apiURL, gucid, logfile=instanceLogfile, pcapfile=nil)
          instanceLogfile.truncate(0)
        end

        if instanceLogfile.length > 50000
          submit_logfile(apiURL, gucid, logfile=instanceLogfile, pcapfile=nil)
          instanceLogfile.truncate(0)
        end
      end

  rescue => err
    $logger.error "[#{Time.now}]: Error #{err.inspect} - see coredump.atr for backtrace/stacktrace"
    File.write("#{err.inspect} \n ###############\n #{err.backtrace} \n--------END DUMP----------\n\n"
    sleep $options[:retry]
    retry
  ensure
    #  File.close
  end
end
