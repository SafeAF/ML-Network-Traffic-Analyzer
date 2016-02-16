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

##########
# Specify custom ca certs. If prod system only connects to one particular server should specify these
# and bundle them with the app so not dpeendent on OS level pre installed certs in prod env
store = OpenSSL::X509::Store.new
store.set_defaults_paths
store.add_cert(OpenSSL::X509::Certificate.new(File.read("/path/to/ca1.crt")))
store.add_file("path/crt")
http.cert_store = store

## Client cert example. some servers ue this to authorize the connecting client ie you. The server you connect to get thes cert you speicfy and
# they ccan use it to check who signed the cert and use the cert fingerprint to identify exaclty which cert your using

http=Net::HTTP.new('verysecure.com', 443)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
http.key = OpenSSL::PKey::RSA.new(File.read("/path/to/client.key"), "optional passphrase arg")
http.cert = OpenSSL::X509::Certificate.new(File.read("/path/to/client.crt"))
response = http.request(Net::HTTP::Get.new("/"))

######)
# skip verification, generally a bad idea
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

