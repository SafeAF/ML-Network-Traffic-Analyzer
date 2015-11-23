#!/usr/bin/env ruby
require 'pp'
#require 'hiredis'
require 'redis'
require 'json'
require 'daemons'

require 'redis-objects'
#require 'activerecord'
require 'connection_pool'
require 'sinatra/base'
#require 'sinatra/content_for'
#require 'sinatra/namespace'
# require 'sinatra/contrib'
# require 'sinatra/contrib/all'

ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db'].each do |folder|
  $:.unshift File.join(ROOT, folder)
end

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')
$VERSION = '1.0.0'
$DATE = '07/15/15'


Dir[File.dirname(__FILE__) + '../lib*.rb'].each do |file|
  require File.basename(file, File.extname(file))
end

$options = {}
$options[:host] = '10.0.1.17'
$options[:db] = 10
$options[:port] = '6379'
$messagehub = 'system:messages'
$alerthub = 'system:alerts'
$notifyhub = 'system:notifcations'
$emailhub = 'system:email'
#ActiveRecord::Base.logger = Logger.new('log/db.log')
#	ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))
#end
#ActiveRecord::Base.establish_connection('development')
# ActiveRecord::Base.establish_connection(
#     :adapter => 'mysql2',
#     :database => 'emergence',
#     :username => 'emergence',
#     :password => '#GDU3im=86jDFAipJ(f7*rTKuc',
#     :host => 'datastore2')

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:db]})}

$messages = Redis::List.new($messagehub, :marshall => true)
$notifications = Redis::List.new($notifyhub, :marshall => true)
$alerts =  Redis::List.new($alerthub, :marshall => true)
$email =  Redis::List.new($emailhub, :marshall => true)

module Statistics
 class Messages
   def self.total
     @@total = 0 if @@total.nil?
     @@total
   end

   def self.total=(val)
     @@total = val
   end

 end

 class Notifications
   def self.total
     @@total = 0 if @@total.nil?
     @@total
   end

   def self.total=(val)
     @@total = val
   end

 end

 class Alerts
   def self.total
     @@total = 0 if @@total.nil?
     @@total
   end

   def self.total=(val)
     @@total = val
   end

 end

 class Emails
   def self.total
     @@total = 0 if @@total.nil?
     @@total
   end

   def self.total=(val)
     @@total = val
   end

 end


end

module Parser
  attr_accessor :message

  def self.parse(message)

    # send email using ssmtp
    # needs a template?
    if message[:Message] =~ /sudo|.*\bsu\b.*/i
     `echo "#{message[:Message]}" | ssmtp -v support@baremetalnetworks.com`
    end

  end
end

begin
  class MessageHub < Sinatra::Base
    # common extensions
    # # register Sinatra::Contrib
    #all extension
    # ge the same line  here but 1 line diff in require -> 'sinatra/contrib/all'
    attr_accessor :user_obj
    set :server, :thin
    set :port, 5555
    set :environment, :production
    #before do ; expires 300, :public, :must_revalidate ;end # before filter use instead of in method, protip

    def initialize
      $logger.info "#{Time.now}:#{self.class}:IP##{__LINE__}: Received request"
    end

    get '/' do
      "MessageHub v#{$VERSION}. MessageHub Needs a minimal dashboard, include bootstrappus-maxiumus" +
       "<br/>Dashboard should show messages sitting in their redis lists and msgs waiting to process." +
      "<br/>Also show graphs or something of shit thats been processed. This should easily fork into a dash for powersaw".to_json
    end

    post '/notification' do
      $DBG = false
      pp env if $DBG
      ret = {}

      msg = {}
      msg[:header] = request.params[:header]
      msg[:body] = request.params[:body]
      msg[:date] = Time.now
      $notification.push(msg.to_json)
      Statistics::Notifications.total += 1
      ret[:body] = "#{msg[:date]} Your notification was received, we hope. Thank you for your submission"
    end

    post '/message.json' do
      $DBG = false
      pp env if $DBG
      ret = {}

      msg = {}
      # msg[:header] = request.params[:header]
      # msg[:body] = request.params[:body]
      # msg[:date] = Time.now
      # $message.push(msg.to_json)
      ret[:body] = "Thank you for your submission".to_json
    end

    post '/message' do
      $DBG = false
      pp env if $DBG
      ret = {}
      q = request.params
      msg = {}
      msg[:id] = q[:id] if !q[:id].nil?
      ### Syslog message format ###
      msg[:FromHost] = q[:fromhost] if !q[:facility].nil?
      msg[:Priority] = q[:priority]  ### TODO throw errorif no have mandatory
      msg[:Facility] = q[:facility] if !q[:facility].nil?
      msg[:DeviceReportedTime] = q[:DeviceReportedTime] if !q[:DeviceReportedTime].nil?
      msg[:ReceivedAt] = q[:receivedat]
      msg[:Message] = q[:message]
      msg[:SysLogTag] = q[:syslogtag] if !q[:syslogtag].nil?
      msg[:InfoUnitID] = q[:infounitid] if ! q[:infounitid].nil?
      ### Extended Message Format (BareMetal) ###
      msg[:hubReceivedAt] = Time.now
      msg[:header] = q[:header] if !q[:header].nil?
      msg[:body] = q[:body] if !q[:body].nil?
      $message.push(msg.to_json)
      parser = MessageParser.new
     actioned = parser.parse(msg).map{ |actionable| if actionable.action.include? 'email'; send_email(actionable); end}

      elapsed = "#{msg[:hubReceivedAt] - Time.now}"
      p "#{Time.now} Processed #{msg[:Message]} in #{elapsed}s"
      ret[:body] = "#{elapsed}s elapsed processing your crummy message. Your notification was received, we hope." # Syslog doesn't listen so it probalby doesnt matter
    end




    def self.new(*)

      app = Rack::Auth::Digest::MD5.new(super) do |username, password|
        $logger.info "Authentication Request: #{username}:#{password}"
        {'foo'=> 'bar'}[username]

        # @user_obj = User.authenticate(username, password)
      end

      app.realm = "TitanGlobal Message Hub"
      app.opaque = "eikjalkjalosdfjSecret3pij398323543klhj2lh4tkth4858674"
      app
    end

  end

rescue => err
  pp err.inspect
end







############ EOF NOTES ################

__END__
# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :documents, force: true do |t|
    t.integer :id
    t.string :name
    t.string :path

  end

  add_index "wordlists", ["page_id"], :name=> "doc_pages_words"
end

# Define the models
class Document < ActiveRecord::Base
  has_many :pages
end

class Page < ActiveRecord::Base
  belongs_to :document # inverse_of: :foo, required: true
  has_many :words
end

class Words < ActiveRecord::Base
  belongs_to :page
end