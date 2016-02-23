require 'nmap/program'
require 'nmap/xml'
require 'net/ping'

module Universe


  module Gathering

class Scanning

def netscan(targets = '10.0.1.*', ports = [20,21,22,23,25,80,110,443,512,522,8080,1080])
  Nmap::Program.scan do |nmap|
    nmap.syn_scan = true
    nmap.service_scan = true
    nmap.os_fingerprint = true
    nmap.xml = 'scan.xml'
    nmap.verbose = true

    nmap.ports = ports
    nmap.targets = targets
  end
end


def netscan_parse()
  Nmap::XML.new('scan.xml') do |xml|
    xml.each_host do |host|
      puts "[#{host.ip}]"

      host.each_port do |port|
        puts "  #{port.number}/#{port.protocol}\t#{port.state}\t#{port.service}"
      end
    end
  end
end



def check_server_availability(ip, service='ssh')
  ping = Net::Ping::TCP.new(ip, service)
  ping.ping?
end

end
  end
end
