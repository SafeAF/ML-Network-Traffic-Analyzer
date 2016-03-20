=begin
##################################################################
#### Attrition.IO SSH Log Monitor v0.1.0 03-13-16             ####
#### Copyright (C) 2010-2016 BareMetal Networks Corporation   ####
##################################################################
=end
## Notes ##
# use riptables from github for iptables support
# use threading and mutexes on attr tmpfiles etc
# use proper tempfile gem?
# TODO process log messages so that duplicates are not sent, record only # and time after first one

### INIT ###
require 'logger'
require 'net/http'
#require 'inotify'
require 'json'
require 'rb-inotify'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'json'
require 'socket'

$logger = Logger.new('client.log')


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
   sleep 5
    exit(1)
  end
end


filename = ARGV[0] || '/var/log/auth.log'
instanceLogfile = StringIO.new

monitor_logfile filename do |data|

#  p data
  begin
 instanceLogfile << data
  if (instanceLogfile.size > 1000) || (lastLogSubmit > 30)
   #if submit_logfile
       instanceLogfile.truncate(0)
  # end
  end


  rescue => err
    $logger.error "[#{Time.now}]: Error #{err}"
    sleep $options[:retry]
    retry
  ensure
    #  File.close
  end
end

