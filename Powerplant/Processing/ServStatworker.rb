require 'net/ping'
require 'sidekiq'
require 'mongoid'

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

class Vserver
  include Mongoid::Document
 # include Redis::Objects

 # value :box
 # hash_key :statistics
  field :address, type: String
  field  :hostname, type: String
  field :up, type: Boolean
  field :cpus, type: String
  field :user, type: String
  field :lastSeen, type: DateTime
  field :firstSeen, type: DateTime

  # has_many :diskdrives
#  embeds_many :ServerStatistics
  # def execute(command)
  #   Rye::Box.new(host: self.address, :user =>  self.user)
  # end
end
#
# class ServerStatistics
#   include Mongoid::Documents
#
#   field
# end

app0 = Vserver.create
app0.address = '10.0.1.60'
app0.up = check_server_availability(app0.address, 'ssh')
p app0.up