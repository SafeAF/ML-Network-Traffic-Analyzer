#!/usr/bin/env ruby

#### Attrition Client
### Rewrite of clientsnort-rules-default
#!/usr/bin/env ruby
require 'rubygems'
require 'pcaplet'
httpdump = Pcaplet.new('-s 1500')

HTTP_REQUEST  = Pcap::Filter.new('tcp and dst port 80', httpdump.capture)
HTTP_RESPONSE = Pcap::Filter.new('tcp and src port 80', httpdump.capture)

httpdump.add_filter(HTTP_REQUEST | HTTP_RESPONSE)
httpdump.each_packet {|pkt|
  data = pkt.tcp_data
  case pkt
    when HTTP_REQUEST
      if data and data =~ /^GET\s+(\S+)/
        path = $1
        host = pkt.dst.to_s
        host << ":#{pkt.dst_port}" if pkt.dport != 80
        s = "#{pkt.src}:#{pkt.sport} > GET http://#{host}#{path}"
      end
    when HTTP_RESPONSE
      if data and data =~ /^(HTTP\/.*)$/
        status = $1
        s = "#{pkt.dst}:#{pkt.dport} < #{status}"
      end
  end
  puts s if s
}


#!/usr/bin/env ruby
require 'rubygems'
require 'pcaplet'
include Pcap

class Time
  # tcpdump style format
  def to_s
    sprintf "%0.2d:%0.2d:%0.2d.%0.6d", hour, min, sec, tv_usec
  end
end

pcaplet = Pcaplet.new
pcaplet.each_packet { |pkt|
  print "#{pkt.time} #{pkt}"
  if pkt.tcp?
    print " (#{pkt.tcp_data_len})"
    print " ack #{pkt.tcp_ack}" if pkt.tcp_ack?
    print " win #{pkt.tcp_win}"
  end
  if pkt.ip?
    print " (DF)" if pkt.ip_df?
  end
  print "\n"
}
pcaplet.close