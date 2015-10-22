require File.expand_path '../server.rb', __FILE__

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

run Switchyard
