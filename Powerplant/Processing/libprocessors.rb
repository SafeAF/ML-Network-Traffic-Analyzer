# Notes
# Clients push job onto queque, server does actual processing.
# Use sidekiq for high latency io like network requests
# use delayed job for cpu intensive jobs

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12' }
end



class Bar


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

class CronishGameHen
  include Sidekiq::Worker
  include Mongoid::Document
  include Redis::Objects

  sidekiq_options :retry => 25, :dead => true

end

# BanlistWoerker Sidekiq
## Create banlists from banevents stream throughout the day
### Run every hour?
class BanListWorker
  include Sidekiq::Worker
  include Mongoid::Document
  include Redis::Objects

  sidekiq_options :retry => 25, :dead => true

end


class SysLogsWorker
  include Sidekiq::Worker
  include Mongoid::Document
  include Redis::Objects

  sidekiq_options :retry => 5, :dead => false

    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"

  end

    # Act on the triple notifications classes queque in redis
  class MessageQuequeWorker
    include Sidekiq::Worker
    include Mongoid::Document
    include Redis::Objects

    sidekiq_options :retry => 5, :dead => false

    sidekiq_retries_exhausted do |msg|
      Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"

    end

## Calling worker
#MyWorker.perform_async(1, 2, 3)
#Sidekiq::Client.push('class' => MyWorker, 'args' => [1, 2, 3])  # Lower-level generic API

  # Sidekiq.configure_server do |config|
  #   # runs after your app has finished initializing but before any jobs are dispatched.
  #   config.on(:startup) do
  #     make_some_singleton
  #   end
  #   config.on(:quiet) do
  #     puts "Got USR1, stopping further job processing..."
  #   end
  #   config.on(:shutdown) do
  #     puts "Got TERM, shutting down process..."
  #     stop_the_world
  #   end
  # end

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