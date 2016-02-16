require 'net/ping'

def check_server_availability(ip, service='ssh')
  ping = Net::Ping::TCP.new(ip, service)
  ping.ping?
end

check_server_availability('10.0.1.200')


def ping_repeatedly(ip, count)

  @icmp = Net::Ping::ICMP.new(ip)
  rtary = []
  pingfails = 0
  repeat = count
  puts 'starting to ping'
  (1..repeat).each do

    if @icmp.ping
      rtary << @icmp.duration
      puts "host replied in #{@icmp.duration}"
    else
      pingfails += 1
      puts "timeout"
    end
  end
  avg = rtary.inject(0) {|sum, i| sum + i}/(repeat - pingfails)
  puts "Average round-trip is #{avg}\n"
  puts "#{pingfails} packets were droped"

end