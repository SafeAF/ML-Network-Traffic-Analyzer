require File.expand_path '../demoserver.rb', __FILE__

# app = proc do |env|
#   body = ['hi']
#   [
#       200, {'Content-Type' => 'text/html'},
#       body
#   ]
# end
#
# run Rack::URLMap.new({
#                          '/' => Public,
#                          'config' => Protected,
#                          '/logs' => Protected,
#                      })
#set :port, 3001
#
# configure do
# 	set :server, :thin
# 	set :port, 3000
# 	set :environment, :production
# end
run DemoAPI
