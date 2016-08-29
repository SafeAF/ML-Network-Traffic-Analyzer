  #!/usr/bin/env ruby
require 'pp'
#require 'hiredis'
require 'redis'
require 'json'
require 'daemons'
#require 'gmail'
  require 'connection_pool'
require 'redis-objects'
#require 'activerecord'
require 'connection_pool'
require 'sinatra/base'
#require 'sinatra/content_for'
#require 'sinatra/namespace'
# require 'sinatra/contrib'
# require 'sinatra/contrib/all'

  ####################################
  ## Notes

  ## thin start -p 3001 -e production —threaded
  ## thin install
  ##   sudo /usr/sbin/update-rc.d -f thin defaults
  ## thin restart -C /etc/thin/app.yml <-- to start stop individual thin apps
  #################

  ## Thin Config
  #
  # ---
  # user: www-data
  # group: www-data
  # pid: tmp/pids/thin.pid
  # timeout: 30
  # wait: 30
  # log: log/thin.log
  # max_conns: 1024
  # require: []
  # environment: production
  # max_persistent_conns: 512
  # servers: 1
  # threaded: true
  # no-epoll: true
  # daemonize: true
  # socket: tmp/sockets/thin.sock
  # chdir: /path/to/your/apps/root
  # tag: a-name-to-show-up-in-ps aux

  #####################################
ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db'].each do |folder|
  $:.unshift File.join(ROOT, folder)
end

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')
  require 'libstats'


$VERSION = '0.1.1'
$DATE = '12/15/15'

#  require File.expand_path(File.dirname(__FILE__) + '/liblust')

Dir[File.dirname(__FILE__) + '../lib*.rb'].each do |file|
  require File.basename(file, File.extname(file))
end
$operatorWorkstationURI = ' vishnu@10.0.1.8 '
$notifySend = true
$options = {}
$options[:host] = '10.0.1.75'
$options[:db] = 10
$options[:port] = '6379'
$messagehub = 'system:messages'
$alerthub = 'system:alerts'
$notifyhub = 'system:notifcations'
$emailhub = 'system:email'
$notifysend = ARGV[0] || 'ssh vishnu@10.0.1.8 notify-send '

username = 'support@baremetalnetworks.com'
password = 'todkjw29347@'

api = Gmail.new(username, password)


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

  $redis = Redis.current

$messages = Redis::List.new($messagehub, :marshall => true)
$notifications = Redis::List.new($notifyhub, :marshall => true)
$alerts =  Redis::List.new($alerthub, :marshall => true)
$email =  Redis::List.new($emailhub, :marshall => true)

 def send_desktop_notification(header, body)

   `ssh #{$operatorWorkstationURI} notifysend  "#{body}"`

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
      "MessageHub v#{$VERSION}. MessageHub Needs a minimal dashboard, include bootstrappus-maxiumus<br/>" +
      "Notifications#{Statistics::Notifications.total}"
       "<br/>Dashboard should show messages sitting in their redis lists and msgs waiting to process." +
      "<br/>Also show graphs or something of shit thats been processed. This should easily fork into a dash for powersaw".to_json
    end

    post '/alarm.json' do

      bod = JSON.parse(request.params[:body])
      header = JSON.parse(request.params[:header])
      $alarm.push(request.params[:header] + request.params[:bod])
      send_desktop_notification(header, bod)
      "#{Time.now} Success!".to_json
    end

    post '/alarm' do
      bod = params[:body].to_s
      header = params[:header].to_s

      $alerts.push([header, bod].join(" ").to_json)
     # send_desktop_notification(header, bod)
      `notify-send \'#{header}\'  \'#{bod}\'`
      "#{Time.now} Success!".to_json
    end


    post '/notification.json' do
      $DBG = false
      pp env if $DBG
      ret = {}

      msg = {}
      msg[:header] = JSON.parse(request.params[:header])
      msg[:body] = request.params[:body]
      msg[:date] = Time.now
      $notification.push(msg.to_json)
      Statistics::Notifications.total += 1
      send_desktop_notification(msg) if $notifySend
      ret[:body] = "#{msg[:date]} Your notification was received, we hope. Maybe. Keep sending them this is /dev/null baby"
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
      send_desktop_notification(msg) if $notifysend
      elapsed = "#{msg[:hubReceivedAt] - Time.now}"
      p "#{Time.now} Processed #{msg[:Message]} in #{elapsed}s"
      ret[:body] = "#{elapsed}s elapsed processing your crummy message. Your notification was received, we hope." # Syslog doesn't listen so it probalby doesnt matter
    end

    post '/pubsys' do
     $redis.publish 'system', request.params[:message].to_json
    end


    # def self.new(*)
    #
    #   app = Rack::Auth::Digest::MD5.new(super) do |username, password|
    #     $logger.info "Authentication Request: #{username}:#{password}"
    #     {'foo'=> 'bar'}[username]
    #
    #     # @user_obj = User.authenticate(username, password)
    #   end
    #
    #   app.realm = "TitanGlobal Message Hub"
    #   app.opaque = "eikjalkjalosdfjSecret3pij398323543klhj2lh4tkth4858674"
    #   app
    # end

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