require 'rye'
require 'net/ssh'
# allow command_name, 'path/commd', 'def arg', 'another arg'
ips = %w[10.0.1.190 10.0.1.200 10.0.1.60 10.0.1.61 10.0.1.62 10.0.1.63 10.0.1.30 10.0.1.31 10.0.1.32 10.0.1.33 10.0.1.240  10.0.1.241]
ips += %w[10.0.1.14 10.0.1.50 10.0.1.191 10.0.1.75  10.0.1.20  10.0.1.62  10.0.1.120  10.0.1.221  10.0.1.39]

p "[#{Time.now}]: Adding #{ips.length} Hosts to Integrated Management Module [IMS]"
ips.each do |ip|
node = Rye::Box.new(ip, {user: 'vishnu', safe: false})

res = node.ssh-copy-id "vishnu\@#{ip}"e
p res.stdout
  end

def run
  loop do
end
### Lets deploy sidekiq process cluster