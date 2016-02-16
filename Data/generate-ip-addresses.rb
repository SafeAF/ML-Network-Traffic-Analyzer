require 'ipaddress'
require 'mongo'

# This is gonna be super shitty but who cares
$client = Mongo::Client.new([ '10.0.1.30:27017' ], :database => 'globalips')
$addressSpace = 4_294_967_296
$totalIPsgenerated = 0
while $totalIPsgenerated < $addressSpace # ($addressSpace + 1) ?
  rawip = (rand(255)<<24)+(rand(255)<<16)+(rand(255)<<8)+rand(255)
  ipclass = IPAddress::IPv4::parse_u32 rawip
  ip = ipclass.address

  if $client[:ips].find(address: ip).count.inspect.to_i == 0
    result = $client[:ips].insert_one({ address: ip })
    $totalIPsgenerated += result.n.to_i

    if $totalIPsgenerated.to_i % 10
      p 'We have generated: ' +  $totalIPsgenerated.to_s
    end
  end
end


## Crazzeeuhh i estimate this 'algorithm' is O(N^2) best case!
## Omg this is fucked up, it started at 23:29 and its now past
## 23:42 and its just starting to produce a few visible gaps
## in printing to stdout.. gaps being chunks of addresses that
## are already in the db.




__END__
documents = client[:artists].find(:name => 'Flying Lotus').skip(10).limit(10)
documents.each do |document|
  #=> Yields a BSON::Document.
end