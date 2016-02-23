# Datetime Array BigDecimal Boolean Date DateTime Float Hash Integer
# BSON::Binary BSON::OBjectId Range Regexp String Symbol Time TimeWithZone
require 'connection_pool'
require 'redis-objects'
require 'mongo'
require 'mongoid'
#require 'sinatra/base'
require 'json'
require 'pp'

#require File.expand_path(File.dirname(__FILE__) + '/libtimongo')
#require File.expand_path(File.dirname(__FILE__) + '/libnetutils')
# $options = {};$options[:redhost] = ARGV[0] || '10.0.1.75' ;$options[:redport] = '6379'
# $options[:redtable] = 5
# $options[:mongodb] = 'attrition'
# $options[:mongoconnector] = ARGV[1] || '10.0.1.30:27017'
#
# Redis::Objects.redis = ConnectionPool.new(size: 15, timeout: 5) {
#   Redis.new({host: $options[:redhost], port: $options[:redport], db: $options[:redtable]})}
#
# Mongoid.load!('mongoid.yml', :development)
# $MONGO = Mongo::Client.new([$options[:mongoconnector]], :database => $options[:mongodb])
#
# $logger = Mongo::Logger.logger = Logger.new($stdout);Mongo::Logger.logger.level = Logger::INFO
#
# $logger.info  "Connecting to MongoDB @ #{$options[:mongoconnector]}, using database: #{$options[:mongodb]}"
#
# $logger.info "Connecting to Redis @ #{$options[:redhost]}, using database: #{$options[:redtable]}"

class GlobalIP
  include Mongoid::Document
  include Redis::Objects
  include Mongoid::Timestamps

  field :address, type: String
  field :organization, type: String
  field :codename, type: String
  field :domains, type: Array
  field :geoloc, type: String
  field :whois
  field :reverselookup

  has_one :ban
#

end

class Bans
  include Mongoid::Document
  include Redis::Objects
  include Mongoid::Timestamps

  field :address, type: String
  field :id, type: Integer
  field :banned, type: Boolean
  field :banIntensity, type: Float
  field :banDuration, type: Integer
  field :firstBan, type: DateTime
  field :prevBan, type: DateTime
  field :totalBans, type: Integer
  #field :banLocality, type: String
 # field :banevents, type: Hash

  embeds_many :attacks
end

class Attacks
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  field :name
  field :type
  field :exploit
  field :payload
  field :sources, type: Hash
  field :sports, type: Hash
  field :dest
  field :dport
  field :occurence, type: DateTime
  field :attacksLikeThis, type: Integer
  field :frequency, type: Float
  field :repWeighting, type: Float
  field :targetNation
  field :sourceNation




  embedded_in :ban
end

class Credibility
  include Mongoid::Document

  field :address, type: String
  field :banned, type: Boolean
  field :credibility, type: Float
  field :confidence, type: Float
  field :reputation, type: Float
  field :banDates, type: Array
  field :banEvents, type: Hash
end

class Enemypositions
  include Mongoid::Document

  field :address, type: String
  field :services, type: Hash
  field :os, type: String

end

## Reputation Class: Stores an float value
# Inputs:  Changes in reputation mediated by outside factors, namely bloodlust workers.
# Outputs: Effects changes in Bans model
class Reputation
  include Mongoid::Document
  include Redis::Objects


  #value :reputation


end


