require 'mongo'

# This is gonna be super shitty but who cares
$client = Mongo::Client.new([ '10.0.1.30:27017' ], :database => 'globalips')
$addressSpace = 4_294_967_296


v =  $client[:ips].find().first
p v.class
p v.to_s
p v.methods - Object.methods