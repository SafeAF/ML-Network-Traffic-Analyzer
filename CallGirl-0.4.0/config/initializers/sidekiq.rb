sidekiq_config = {
	#	url: ENV['BACKGROUND_URL'],
	url: 'redis://stack0:6379/6',
    namespace: "baremetal_cg::sidekiq_#{Rails.env}"
}

Sidekiq.configure_server do |config|
	config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
	config.redis = sidekiq_config

end
