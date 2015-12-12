#class PurgeDbJob < ActiveJob::Base
class PurgeDbJob
  include Sidekiq::Worker

  queue_as :datastore

 rescue_from(ActiveRecord::RecordNotFound) do |exception|
   # do something with the exception
  end
 # UserMailer.welcome(@user).deliver_later

   before_enqueue do |job|
    # do something with the job instance
  end
 

   around_enqueue do |job|
    # do something with the job instance
  end

   after_enqueue do |job|
    # do something with the job instance
  end


    before_perform do |job, block|
    # do something before perform
    block.call
    # do something after perform
  end


  around_perform do |job, block|
    # do something before perform
    block.call
    # do something after perform
  end

    after_perform do |job, block|
    # do something before perform
    block.call
    # do something after perform
  end



  #def perform(*args)
  def perform(count)
    Sidekiq.redis do |conn|
      conn.incrby('foo', count)
    end
  end
end

PurgeDbJob.set(wait: 1.week).perform_later(record)