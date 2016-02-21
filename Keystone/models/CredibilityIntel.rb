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

class BloodlustMachineLearning
  include Mongoid::Document
 # include Redis::Objects

  field :name, type: String
  field :training_memory, type: String
  field :frozenbloodlust, type: String
  field :bloodlust_id, type: Integer
  field :service, type: String
  field :library, type: String
  field :operating_efficiency, type: Float
  field :false_positives, type: Float
  field :false_negatives, type: Float
  field :ops_per_sec
  field :id, type: Integer

  def id ; @id ; end

  def id=
    @id = SecureRandom.hex(12)
  end
  #
  # def self.defer
  #   perform_async
  #   sidekiq_options :retry => 25, :dead => true, :queue => syslog
  # end
  #
end

class Bans
  include Mongoid::Document
  include Redis::Objects

  field :address, type: String
  field :id, type: Integer
  field :banevents, type: Hash
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

class Logpreprocessor
 include Sidekiq::Worker
 include Mongoid::Document

  #field logs, type: Array
  def perform(*args)

  end

end

