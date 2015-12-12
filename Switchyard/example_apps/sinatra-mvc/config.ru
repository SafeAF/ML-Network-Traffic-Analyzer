require './dependencies'
require './main'

# GZip compession
use Rack::Deflater

map '/assets' do
  environment = Main.sprockets
  run environment
end

map '/' do
  run Sinatra::Application
end
