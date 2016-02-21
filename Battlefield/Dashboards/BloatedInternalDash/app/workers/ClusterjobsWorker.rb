class ClusterjobsWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'switchyard'

 def perform(*args)
   client_push('class' => self, #FIXME change to submitted logs
                'args' => args)
   #
 end

  def sidekiq_options(opts={})
    self.sidekiq_options_hash = get_sidekiq_options.merge(stringify_keys(opts || {}))
  end

  DEFAULT_OPTIONS = { 'retry' => true, 'queue' => 'default' }

  def get_sidekiq_options # :nodoc:
    self.sidekiq_options_hash ||= DEFAULT_OPTIONS
  end
end
