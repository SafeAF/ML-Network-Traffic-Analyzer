require 'sidekiq'
require 'net/ping'

def check_server_availability(ip, service='ssh')
  ping = Net::Ping::TCP.new(ip, service)
  ping.ping?
end


module Vanguard

  class Worker

    class Taster
      include Sidekiq::Worker

      def perform(ip, service='ssh')
        res = check_server_availability(ip, service)
      end

    end
  end
end

#Vanguard::Worker



class TitanCommander
  include Sidekiq::Worker

  def perform(cmd = 'who', host = 'all', user = 'vishnu', ryeset=nil)
    rbox = Rye::Box.new(host, {user: user})
    rbox.disable_safe_mode = true
    ret = rbox.execute cmd
    Sidekiq.redis {|conn| ret.stdout}
    ret.stderr
    ret.exit_status
  end

  def cancelled?
    Sidekiq.redis {|c| c.rexists("cancelled-#{jid}")}prettysweet
  end

  def cancel!(jid)
    Sidekiq.redis{|c| c.setex("cancelled-#{jid}", 86400, 1)}
  end
end


class TitanStatusSpy
  include Sidekiq::Worker
  def perform(ip, service='ssh')
    ret = check_server_availability(ip, service)
    if ret
      $SHM[ip] =  Time.now
      vs=Vservers.new(ip: ip, up: true, lastSeen: Time.now)
      vs.upsert
    else
      $SHM[ip] = false ;#  Vservers.find_by(ip: ip) { |serv| serv.up = false}
    end

  end
end


class TitanStatusSpy
  include Sidekiq::Worker
  def perform()

  end
end


# Different kinds of workers i need for TitanV

# 1) Test server availability based on ping test
# 2) Check services availability on said server,
#      services monitored should be based on its chef role/spec
# 3) Run stats gathering? Parse logfiles for actionable events and send
#     corresponding emails or texts.
# 4) Run rootkit hunter etc, do apt get cleans and autoremoves
#




# Attrition Workers Needed

# Other assorted workers



__END__
class AttritionSuperWorker
  include Sidekiq::Worker # :retry => false
  sidekiq_options :queue => :attrition , :backtrace => true, :retry => 5, :dead => false

  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(name, count)
    # #$redis = Redis.current
    # $LOGSERV = Redis::List.new('switchyard:logserver', :marshal => true)
    #
    # $BLOOD = Redis::List.new('yard:connector', :marshal => true) ## transport to bloodlust

  end
end

end

class PruneDatabase
  include Sidekiq::Worker
  include Mongoid::Document
  include Redis::Objects
  #include Sidekiq::Benchmark::Worker

  def self.defer
    perform_async
    sidekiq_options :retry => 25, :dead => true, :queue => syslog
  end
end


def LogPreProcessor
  include Sidekiq::Worker

  def perform(logs)

  end


end

module  VanguardCommander
 extend self # make module methods class mehtods

def self.subscribe
  @channel = defined?(CHANNEL) ? CHANNEL : 'job_server'
  @pubsub = Redis.new
  @pubsub.subscribe(@channel) do |on|
    on.message do |channel, msg|

      # message
      data = JSON.parse(msg)

      # process jobs this worker knows how to complete
      if WorkerMethods.respond_to? data['task']
        do_next_task data['task']
      end

    end
  end
end
en




  # Gush
  #     Defining workflows
  #     The DSL for defining jobs consists of a single
  #               run  method. Here is a complete example of a workflow you can
  #               create:
  # workflows/sample_workflow.rb

  # class SampleWorkflow < Gush::Workflow
  #   def configure(url_to_fetch_from)
  #     run FetchJob1, params: { url: url_to_fetch_from }
  #     run FetchJob2, params: {some_flag: true, url: 'http://url.com'}
  #     run PersistJob1, after: FetchJob1
  #     run PersistJob2, after: FetchJob2
  #     run Normalize,
  #         after: [PersistJob1, PersistJob2],
  #         before: Index
  #     run Index
  #   end
  # end

  # Hint: For debugging purposes you can vizualize the graph using
  # viz  command:
  #          bundle exec gush viz SampleWorkflow
