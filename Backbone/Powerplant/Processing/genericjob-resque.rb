class GenericJob < DelayedJobBase
  DEFAULT_JOB_PRIORITY = 5

  # GenericJob.publish( Product, :find, :args=>[:all, {:conditions=>"1 = 2"}], :priority=>3 )
  def self.publish(klass, method, options={})
    args = options[:args] || []
    args = GenericJob.serialize_ar(args)
    priority = options[:priority] || DEFAULT_JOB_PRIORITY
    Delayed::Job.enqueue self.new(:class_name => klass.to_s, :method_name => method, :args => args), priority
  end

  def perform
    klass = message[:class_name].constantize
    args = GenericJob.deserialize_ar(message[:args]||[])
    klass.send(message[:method_name], *args)
  end

  private

  def self.serialize_ar(args)
    args.map do |arg|
      if arg.is_a?(ActiveRecord::Base)
        "ActiveRecord:#{arg.class}:#{arg.id}"
      else
        arg
      end
    end
  end

  def self.deserialize_ar(args)
    args.map do |arg|
      if arg.to_s =~ /^ActiveRecord:(\w+):(\d+)$/
        $1.constantize.find($2)
      else
        arg
      end
    end
  end
end

##more

__END__
resque-web
QUEUE='*' COUNT=3 rake resque:workers &

GenericJob.publish(Product, :reindex_all, :args=> [{:limit=>1000}]

Setup

#append to Rakefile
require 'resque/tasks'
namespace :resque do
  task :setup => :environment
end


class GenericJob
  @queue = :generic

  def self.perform(klass, method, options={})
    options = options.with_indifferent_access
    if options.has_key?(:args)
      klass.constantize.send(method, *options[:args])
    else
      klass.constantize.send(method)
    end
  end

  def self.publish(klass, method, options={})
    Resque.enqueue(self, klass.to_s, method.to_s, options)
  end
end