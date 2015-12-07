class SwitchWorker
	include Sidekiq::Worker

	def perform(input)
		sleep input
	end
end
