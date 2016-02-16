# sidekiq_config = {
# 		url: ENV['BACKGROUND_URL'],
#     namespace: "baremetal_cg::sidekiq_#{Rails.env}"
# }
#
# Sidekiq.configure_server do |config|
# 	config.redis = sidekiq_config
# end
#
# Sidekiq.configure_client do |config|
# 	config.redis = sidekiq_config
#
# end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis.example.com:7372/12' }
end