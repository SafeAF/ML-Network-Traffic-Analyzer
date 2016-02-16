# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

## Configuration ## uncomment this if using http reverse proxy like nginx
#ActionController::Base.relative_url_root = "/callgirl/"

## example nginx configuration
#server {
# listen 80;
# location /callgirl/ {
# proxy_pass http://app-node1:3000/;
# }
# }