#!/usr/bin/ruby
# @Author: Samuel Kerr
# @Date:   2016-07-26 13:21:02
# @Last Modified by:   Samuel Kerr
# @Last Modified time: 2016-09-19 14:45:03
require 'redis'
require 'securerandom'
require 'json'

module Worker

  # make module methods class methods
  extend self

  # each worker gets a "unique" id
  WORKER_ID = SecureRandom.hex

  # module container for worker methods
  module WorkerMethods
  end

  # method used to define worker tasks
  def add(task_name, *args, &block)
    raise "Block required" unless block_given?
    WorkerMethods.define_singleton_method task_name, block
  end

  def work

    # process existing tasks in list
    while RedisWorker.got_tasks?
      RedisWorker.do_next_task
    end

    # subscribe for new work
    RedisWorker.subscribe
  end

  class RedisWorker

    # connect to redis for non-pub/sub commands
    @redis = Redis.new

    def self.do_next_task(task=nil)

      # get task if not passed as argument
      task = task_counts.delete_if {|k,v| v==0}.keys.sample if task.nil?

      # pop task from redis list
      json = @redis.lpop task

      return if json.nil?

      # parse the task
      data = JSON.parse json

      # debug output
      puts "WORKER: #{WORKER_ID} - #{data}"

      WorkerMethods.send task, data

    end

    # boolean if any tasks exist
    def self.got_tasks?
      total = task_counts.inject(0) {|sum, n| sum + n[1]}
      return total>0 ? true : false
    end

    # check redis list size for each worker task
    def self.task_counts
      WorkerMethods.singleton_methods.each_with_object({}) {|task, hsh| hsh[task] = @redis.llen task }
    end

    # use redis pub/sub to subscribe to channel for new tasks
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

  end

end
Workers can be created by including the worker module, and calling the add method with a block. file: worker_start.rb

#!/usr/bin/env ruby

CHANNEL = 'job_server'

$:.unshift File.dirname(__FILE__) + '/lib'

require 'worker'

Worker.add :say_wee do |data|
  # data
  puts "wee"
end

Worker.add :say_oh_yah do |data|
  # data
  puts "oh yah"
end

Worker.work
Jobs can be queued like this:

#!/usr/bin/env ruby

require 'redis'
require 'json'

CHANNEL = 'job_server'

redis = Redis.new

tasks = ['say_wee','say_oh_yah']

1000.times do
  task = tasks.sample
  job = {task: tasks.sample}.to_json
  redis.rpush task, job
  redis.publish CHANNEL, job
end
To try it out:

# watch redis
redis-cli monitor

# start a few workers
./worker_start.rb &
./worker_start.rb &
./worker_start.rb &

# queue some jobs
./add_jobs.rb