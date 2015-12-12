class SwitchWorker
	include Sidekiq::Worker
     sidekiq_options :queue => :switchyard
	def perform(input)
		#$redis.push(input)
		$SHMEM.push(input)
		#sleep input
	end

	
end
