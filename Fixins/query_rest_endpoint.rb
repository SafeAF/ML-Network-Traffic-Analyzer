require 'uri'
require 'net/https'
require 'rubygems'
require 'json'

uri = URI.parse(ARGF[0])

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
#http.verify_mode = OpenSSL::SSL::VERIFY_NONE

response = http.request(Net::HTTP::Get.new(uri.request_uri))
p JSON.parse(response.body)
