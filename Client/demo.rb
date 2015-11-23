#!/usr/bin/env ruby

#!/usr/bin/env ruby

# this line imports the libpcap ruby bindings
require 'pcaplet'
$network = Pcaplet.new('-s 50000')
$filter = Pcap::Filter.new('tcp and dst port 80', $network.capture)
$network.add_filter($filter)


def scoop_http()
## Scoop on http requests
# GET /index.ars HTTP/1.1
# Host: arstechnica.com
# User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Firefox/1.0.7
# (Ubuntu package 1.0.7)
# Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
# Accept-Language: en-us,en;q=0.5
# Accept-Encoding: gzip,deflate
# Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7
# Keep-Alive: 300
# Connection: keep-alive
  Thread.new {
    for p in $network
      # if the packet matches the filter and the regexp...
      if $filter =~ p and p.tcp_data =~ /GET(.*)HTTP.*Host:([^rn]*)/xm
        # print the local IP of the requestor and the requested URL
        puts "#{p.src} - http://#{$2.strip}#{$1.strip}"
      end
    end
  }
#  thread.join
  Thread.join
end
__END__


A quick glance at the packet data allows us to see that the relevant information is in the first two lines. We need to extract 'arstechnica.com/index.ars' from those lines and the best way to do it is with a regular expression:

 /GET(.*)HTTP.*Host:([^rn]*)/xm
Now lets rewrite the packet sniffer loop and use the regular expression to extract the relevant information:

Now, when you run the script and load a page, you should see something like the following:

1.1.2.4 - http://arstechnica.com/index.ars
1.1.2.4 - http://origin.arstechnica.com/Templates/ArsTechnica/style.css
1.1.2.4 - http://origin.arstechnica.com/Templates/ArsTechnica/style.css
1.1.2.4 - http://origin.arstechnica.com/Templates/ArsTechnica/StyleSheets/Layout.css
1.1.2.4 - http://origin.arstechnica.com/Templates/ArsTechnica/StyleSheets/FrontPage.css
1.1.2.4 is the local network IP address of the computer that I used to load the Ars Technica web site. If you load web sites on other computers on the network, the URLs will also appear in the list with the associated IPs.

Now for something a bit more ambitious. I used Ruby and libpcap to make a complete AOL Instant Messenger snooper with only 30 lines of code. It intercepts all AIM messages sent and received by computers on the local network. The AIM protocol uses port 5190, so we need to create new filter strings that intercept packets sent to and from port 5190 on remote systems. We also have to create a function that can parse AIM packets and extract the message and the screen name of the user that sent it. Unfortunately, the OSCAR protocol used by AIM is a byzantian mess and it is very difficult to parse consistently. Different AIM clients seem to use slight variations and the parsing mechanism has to be able to account for that.

In order to effectively dissect the packet data, I had to find some reference material to help me out. Unofficial OSCAR documentation provided some critical hints. I figured out which part of the packet string contains the length of the screen name, and I use that to extract the screen name. I was unable to find a position at which the message consistently starts, so I use regular expressions to extract all the contents of the html tags within the packet, and then I strip the html out of that to leave me with the message in plain text form.

The following is the complete AIM sniffer, written with Ruby and libpcap:

aim_sniffer.rb
#!/usr/bin/env ruby

# this line imports the libpcap ruby bindings
require 'pcaplet'

# create a sniffer that grabs the first 1500 bytes of each packet
$network = Pcaplet.new('-s 1500')

def has_nonprint? n
  # figure out if the string has non-printable characters
  n.each_byte {|x| return false if x < 32 or x > 126}
end

def aim_msg_parse p
  # figure out how many text characters are in the screen name
  name_length = p.tcp_data[26..26].unpack("c")
  # extract the screen name from the packet
  name = p.tcp_data[27..(27 + name_length[0])]
  # filter out all other text
  p.tcp_data[85..-1][/<[^>]+>(.*)<//]
  msg = $1.gsub(/<[^>]+>/,"").strip

  # make sure that it is an actual message and then return it
  return [name, msg] if msg and not has_nonprint?(name) and
    name =~ /^[a-zA-Z]/ and not name.include?("/")

  # if it isn't really a text message, return nothing
nil
rescue
end

# make a filter to capture all packets sent to port 80 on a remote server
$www_filter = Pcap::Filter.new('tcp and dst port 80', $network.capture)

# make a filter to capture all packets sent from port 5190 on a remote server
$aim_recv_filter = Pcap::Filter.new('tcp and src port 5190', $network.capture)

# make a filter to capture all packets sent to port 5190 on a remote server
$aim_send_filter = Pcap::Filter.new('tcp and dst port 5190', $network.capture)

# add all the filters
$network.add_filter($aim_recv_filter | $aim_send_filter | $www_filter)

for p in $network
  # if the packet matches the www filter and the regexp...
  if $www_filter =~ p and p.tcp_data =~ /GET(.*)HTTP.*Host:([^rn]*)/xm
    # print the local IP of the requestor and the requested URL
    puts "#{p.src} - http://#{$2.strip}#{$1.strip}"
    # if the packet matches the incoming AIM filter...
  elsif $aim_recv_filter =~ p
    # parse the packet and extract the sn/message
    name, msg = aim_msg_parse p
    # display the local IP, the screen name of the user and the message
    puts "(<-) <#{p.dst}> from #{name}: #{msg}" if name and msg
    # if the packet matches the outgoing AIM filter...
  elsif $aim_send_filter =~ p
    # parse the packet and extract the sn/message
    name, msg = aim_msg_parse p
    # display the local IP, the screen name of the user and the message
    puts "(->) <#{p.src}> to #{name}: #{msg}" if name and msg
  end
end




__END__
class String
	def self.to_hex
		return if self.nil?
		ret = ""
		for i in (0..self.length)
			unless self[i].nil?
				ret += self[i].to_s(16)
			end
		end
		ret
	end

	def self.splitify( pat)
		self.split(/#{pat}/)
	end
end



def timebox
	a = Time.now.to_s.split(/ /)
	a[3]
end

def array_a_file(location)
	if FileTest.exists? location
		log = File.open(location, 'r')
		if log.nil?
			log.close
			return nil
		elsif log.respond_to?("each")
			logs = []
			log.each {|entry| logs.push(entry)}
			log.close
			return logs
		else
			log.close
			@elogger.warn(get_time + '(WARNING) ' +
					              'Error with logfile at #{location}')
			return nil
		end
	else
#			@elogger.warn(get_time + '(WARNING) ' +
#				'Error file #{location} does not exist.')
		return nil
	end
end