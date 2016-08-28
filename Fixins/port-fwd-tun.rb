require 'net/ssh/gateway'

gateway = Net::SSH::Gateway.new('remotehost.com')
#open port 27017 to forward to 127.0.0.1:27017 on remote host above
gateway.open('127.0.0.1', 27017, 27018)
mongo = Mongo::Connection.new('127.0.0.1', 27018) # conect to local port set in prev statement

puts conn.db('mydatabase').stats.inspect

gateway.shutdown!