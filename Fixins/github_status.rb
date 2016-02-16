require 'uri'
require 'net/https'
require 'rubygems'
require 'json'
#gem 'net-http-spy'
#require 'net-http-spy'

##Net::HTTP.http_logger_options = {:trace => true}
#Net::HTTP.http_logger_options = {:body => true}
##Net::HTTP.http_logger_options = {:verbose => true}
#Net::HTTP.http_logger = Logger.new('http.log')

uri = URI.parse("https://status.github.com/api/status.json")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

response = http.request(Net::HTTP::Get.new(uri.request_uri))
p JSON.parse(response.body)

