#\ -s puma
# this code goes in your config.ru
require 'sidekiq'
require 'sidekiq/web'
#require 'sidekiq/monitor'
require 'sidekiq/statistic'
require 'sidekiq/benchmark'
redis_conn = proc {
  Redis.current = Redis.new(:host => '10.0.1.75', :port => 6379, :db => 5)
}
Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 15, &redis_conn)
end
Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end

# Sidekiq.configure_client do |config|
#   config.redis = { :size => 1 }
# end

require 'sidekiq/web'
map '/sidekiq' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'sidekiq' && password == 'sidekiq'
  end

  run Sidekiq::Web
end
##########
#
# require 'sidekiq'
#
# Sidekiq.configure_client do |config|
#   config.redis = { :size => 1 }
# end

###########
## This is for with another sinatra app
# require 'sidekiq/web'
# run Sidekiq::Web
#
# require 'your_app'
#
# require 'sidekiq/web'
# run Rack::URLMap.new('/' => Sinatra::Application, '/sidekiq' => Sidekiq::Web)