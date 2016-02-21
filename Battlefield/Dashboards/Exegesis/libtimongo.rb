# Mongoid
# Datetime Array BigDecimal Boolean Date DateTime Float Hash Integer
# BSON::Binary BSON::OBjectId Range Regexp String Symbol Time TimeWithZone

# Redis objects
# lock :foo, :expiration => 15 #sec
# value :bar
# counter :hits
# list :baz
# set :gaz
# hash_key :foobar
# sorted_set :foofar, :global => true
# @ban = Ban.find_by_address('10.0.1.100')
# @ban.baz << 'caz'
#

# has_and_belongs_to_many :f``
# field :foo_id, type: BSON::ObjectId

#:embeds_many :bars
#:embedded_in :student

require 'mongoid'
require 'redis-objects'
require 'securerandom'
require 'rye'

module At
  module TitanSuperCluster
    module ExistsA
### Virtual Server @TitanSupercluster
      class Vserver
        include Mongoid::Document
        include Redis::Objects

        value :box
        hash_key :statistics
        field :address, type: String
        field  :hostname, type: String
        field :up, type: Boolean
        field :cpus, type: String
        field :user, type: String
        field :lastSeen, type: DateTime
        field :firstSeen, type: DateTime
        field :sshPubKey, type: String
        field :sshPrivKey, type: String
        field :username, type: String
        field :services, type: Hash # services['foo'] = Hash.new()
        field :storage, type: Hash
        field :totalStorage, type: Float
        field :totalStorageUsed, type: Float
        # has_many :diskdrives

        def execute(command)
          Rye::Box.new(host: self.address, :user =>  self.user)
        end
      end

      class DiskDrive
        include Mongoid::Document

        field :storage, type: Hash
        field :totalDisk, type: Integer, default: 1
        field :availDisk, type: Integer, default: 1
        field :percentageUsed, type: Float, default: 100
        field :mountpoint, type: String

        belongs_to :Vserver
      end

      class MachineIntelligence
        include Mongoid::Document
        include Redis::Objects

        field :home, type: String
        field :allegience
        field :name, type: String
        field :training_memory, type: String
        field :bloodlust_id, type: Integer
        field :service, type: String
        field :library, type: String
      end

      class VirtualFileSystem
        include Mongoid::Document

      end

      class Corporation
        include Mongoid::Document

        field :historicalQuotes, type: Hash
      end

#IP.redis.sadd 'foo', 'bar'

      class User
        attr_accessor :user, :pass, :apikey, :apipass, :perm_apikey, :perm_apipass
        attr_accessor :username, :password

        include Mongoid::Document
        include Redis::Objects

        value :user
        value :pass
        value :apikey
        value :apipass

        field :perm_apikey, type: String
        field :perm_apipass, type: String
        field :username, type: String
        field :password, type: String
        field :lastupdate, type: DateTime
        field :lastseen, type: Time
        field :firstseen, type: Time
        def generate_api_key()
          SecureRandom.urlsafe_base64(32)
        end
      end

      class Machine
        include Mongoid::Document
        include Redis::Objects

        field :hostname, type: String
        field :ip, type: String
        field :uuid, type: String
        field :owner, type: String
        field :lastupdate, type: DateTime
        field :lastseen, type: Time
        field :firstseen, type: Time
      end


      class BanList
        include Mongoid::Document
        include Mongoid::Versioning
        include Redis::Objects

        counter :issue
        field :addresses, type: Array
        field :counter, type: Integer
        field :lastupdate, type: DateTime
        field :lastseen, type: Time
        field :firstseen, type: Time

      end


      class Bans
        include Mongoid::Document
        include Redis::Objects

        value :ip
        list :banlist, :marshal => true
        counter :banid

        field :address, type: String
        field :pbanlist, type: Array
        field :counter, type: Integer
        field :lastupdate, type: DateTime
        field :lastseen, type: Time
        field :firstseen, type: Time

      end

      class IP
        include Mongoid::Document

        field :address, type: String
        field :banned, type: Boolean
        field :country, type: String
        field :lastupdate, type: DateTime
        field :lastseen, type: Time
        field :firstseen, type: Time
      end

      class AttackEvent
        include Mongoid::Document
        include Redis::Objects

        field created, type: Time, default: {}
      end
      class Credibility
        include Mongoid::Document

        field :address, type: String
        field :banned, type: Boolean
        # How sure are we that we are sure that we are sure about the level of sureity in our assuradness
        field :credibility, type: Float
        # Statistical significance of our value, at this point in time, or as a cumulative ? who knows
        field :confidence, type: Float
        # reputation maxes at 100.00 with anything over famous aka celebrity aka google dns or level3
        # or globalxing type infrastructure backbone type shit on perma whitelist so no spoof powered
        # reflecting ban DOS and def no roflcopters!
        field :reputation, type: Float
        field :banDates, type: Array
        field :banEvents, type: Hash
        field :lastUpdate, type: DateTime
        field :lastSeen, type: Time
        field :firstSeen, type: Time
      end

      class Instance
        include Mongoid::Document
        include Redis::Objects

        field :uuid, type: String
        field :instance_type, type: String
        field :lastUpdate, type: DateTime
        field :lastSeen, type: Time
        field :firstSeen, type: Time
      end

      class Server
        include Mongoid::Document
        # has_many :ips
        field :first_ban_date, type: Date
        belongs_to :ip
        field :lastUpdate, type: DateTime
        field :lastSeen, type: Time
        field :firstSeen, type: Time
      end

      class Connection
        include Mongoid::Document
        include Redis::Objects

        field :protocol
        field :destination
        field :source
        field :lastUpdate, type: DateTime
        field :lastSeen, type: Time
        field :firstSeen, type: Time
        field :threatLevel, type: Float
        field :country, type: String
        field :credibility, type: String
        field :action, type: String
        field :drop?, type: Boolean
        field :seenCount, type: Integer

      end

      class Process
        include Mongoid::Document
        include Redis::Objects

        value :pid
        value :name
        value :binary
        value :stat
        value :time
        value :command
        value :tty
        counter :occurances
        counter :starts
        counter :stops
        counter :restarts
        counter :crashes

        field :processName, type: String
        field :firstSeen
        field :lastSeen
        field :threatLevel, type: Float
        field :networked?, type: Boolean
        field :connectionInfo, type: Hash

      end
## Reputation Class: Stores an float value
# Inputs:  Changes in reputation mediated by outside factors, namely bloodlust workers.
# Outputs: Effects changes in Bans model
      class Reputation
        include Mongoid::Document
        include Redis::Objects

        value :reputation


      end



# class SwitchWorker
#   include Sidekiq::Worker
#   sidekiq_options :queue => :switchyard
#   def perform(input)
#     #$redis.push(input)
#     $SHMEM.push(input)
#     #sleep input
#   end
#
#
# end
#
# @class = Klass.where(name: 'something').first
#
# @total_students = @class.students.count
#
# @present_students = @class.students.where('attendances.status' => '1').count
#
# @absent_students = @class.students.where('attendances.status' => '2').count
#
# @p_s_today = @class.students.where('attendances.status' => '1', 'attendances.created_at' => {'$gte' => Date.today} ).count
#
# @a_s_today = @class.students.where('attendances.status' => '2', 'attendances.created_at' => {'$gte' => Date.today} ).count
#
# @students_present_today = @class.students.where({ attendances: { '$elemMatch' => {status: 1, :created_at.gte => Date.today} } }).count
# @students_absent_today = @class.students.where({ attendances: { '$elemMatch' => {status: 2, :created_at.gte => Date.today} } }).count