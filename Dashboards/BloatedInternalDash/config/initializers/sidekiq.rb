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
  config.redis = { url: 'redis://10.0.1.75:7372/12' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://10.0.1.75:7372/12' }
end

#
# # for redis failover/sentinel
# redis_conn = proc {
#   Redis.new # do anything you want here
# }
# Sidekiq.configure_client do |config|
#   config.redis = ConnectionPool.new(size: 5, &redis_conn)
# end
# Sidekiq.configure_server do |config|
#   config.redis = ConnectionPool.new(size: 25, &redis_conn)
# end
