require 'mongoid'
require 'redis-objects'
require 'rye'
require 'net/ping'
require 'sidekiq'
require 'mongoid'
require 'nmap/program'
require 'nmap/xml'
require_relative 'user'
# require 'acts_as_api'

# Datetime Array BigDecimal Boolean Date DateTime Float Hash Integer
# BSON::Binary BSON::OBjectId Range Regexp String Symbol Time TimeWithZone

# gem install ruby-nmap
$options = {};$options[:redhost] = ARGV[0] || '10.0.1.75' ;$options[:redport] = '6379'
$options[:redtable] = 5
$options[:mongodb] = 'attrition'
$options[:mongoconnector] = ARGV[1] || '10.0.1.30:27017'

Redis::Objects.redis = ConnectionPool.new(size: 15, timeout: 5) {
  Redis.new({host: $options[:redhost], port: $options[:redport], db: $options[:redtable]})}

Mongoid.load!('mongoid.yml', :development)
$MONGO = Mongo::Client.new([$options[:mongoconnector]], :database => $options[:mongodb])

$logger = Mongo::Logger.logger = Logger.new($stdout);Mongo::Logger.logger.level = Logger::INFO

$logger.info  "Connecting to MongoDB @ #{$options[:mongoconnector]}, using database: #{$options[:mongodb]}"

$logger.info "Connecting to Redis @ #{$options[:redhost]}, using database: #{$options[:redtable]}"

# Attach ourselves to Mongoid
# if defined?(Mongoid::Document)
#   Mongoid::Document.send :include, ActsAsApi::Adapters::Mongoid
# end


def check_server_availability(ip, service='ssh')
  ping = Net::Ping::TCP.new(ip, service)
  ping.ping?
end


module Mongoid
  module Config
    def load_configuration_hash(settings)
      load_configuration(settings)
    end
  end
end

Mongoid.load!('mongoid.yml', :development)

#  thin -C production-thin.yml -R config.ru start
# bundle exec sidekiq -r ./reserver.rb
#### Installation
# class Diskdrive
#   include Mongoid::Document
#
#   field :storage, type: Hash
#   field :totalDisk, type: Integer, default: 1
#   field :availDisk, type: Integer, default: 1
#   field :percentageUsed, type: Float, default: 100
#   field :mountpoint, type: String
#
#   embedded_in :vserver
# end
#
# class User
#   include Mongoid::Document
#
#   field :first_name, :type => String
#   field :last_name, :type => String
#   field :age, :type => Integer
#   field :active, :type => Boolean
#
#   acts_as_api
#
#   api_accessible :name_only do |template|
#     template.add :first_name
#     template.add :last_name
#   end
#
# end

class Supercluster
  include Mongoid::Document

  field :name, type: String
  field :members, type: Hash
  field :public_ip, type: String
  field :ip, type: String
  field :version, type: String

  field :services, type: Hash
  field :processes, type: Hash
  field :connections, type: Hash
  field :openPorts, type: Hash

  field :mem, type: Hash
  field :load, type: Hash
  field :disk, type: Hash

# autosave on relationional associations (embedded dont need)
  # cascade_callbacks  #fire any vserver callbacks on persist
  has_many :vservers , autosave: true#, cascade_callbacks: true op
end

class Vservers
  include Mongoid::Document
  include Mongoid::Timestamps
  # include Redis::Objects

  # value :box
  # hash_key :statistics
  field :ip, type: String
  field :address, type: String
  field  :hostname, type: String
  field :up, type: Boolean
  field :cpus, type: String
  field :ram, type: Integer
  field :users, type: Hash # embed user with key value
  field :lastUp, type: DateTime
  field :firstUp, type: DateTime
  field :lastDown, type: DateTime

  field :services, type: Hash
  field :processes, type: Hash
  field :connections, type: Hash
  field :openPorts, type: Hash

  field :mem, type: Hash
  field :load, type: Hash
  field :disk, type: Hash
  field :inbound, type: Array
  field :outbound, type: Array
  field :listeners, type: Hash
  field :connections, type: Hash

  belongs_to :supercluster
 # embeds_many :diskdrives
  embeds_many :scanresults

    # acts_as_api
    #
    # api_accessible :name_only do |template|
    #   template.add :first_name
    #   template.add :last_name
    # end

 # vserver.supercluster_attributes = { name: "Flood" }
  # has_many :diskdrives
  #  embeds_many :ServerStatistics
  # def execute(command)
  #   Rye::Box.new(host: self.address, :user =>  self.user)
  # end
end
#
class Serverstatistics
  include Mongoid::Document

  field :name, type: String
  field :value, type: Float

end

class Connections
  include Mongoid::Document

  field :timeslice, type: DateTime
  field :inbound, type: Array
  field :outbound, type: Array
  field :listeners, type: Hash
  field :connections, type: Hash
end

class Scanresult
  include Mongoid::Document

  field :timeslice, type: DateTime
end
#
#
# #
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




# Vservers.all.each {|x| p x}


  # netscan()
  # netscan_parse()
# class VserverWorker
#   include Sidekiq::Worker
#
app0 = Vservers.create
app0.address = '10.0.1.60'
app0.up = check_server_availability(app0.address, 'ssh')
p app0.up

#p Vservers.all

def delete(klass=Vserver)
klass.delete_all
end
app0 = Vservers.new
app0.address = '10.0.1.60'
app0.up = check_server_availability(app0.address, 'ssh')
app0.upsert
p app0.up

 Vservers.all.each{|x| p x}

require 'ipaddr'

ips = IPAddr.new("10.0.1.0/24").to_range
