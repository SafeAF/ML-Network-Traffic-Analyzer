=begin
##################################################################
#### ADAPTIVE DEFENSE INFRASTRUCTURE -- ADI v0.2.1 11-23-15   ####
#### SWITCHYARD  MIDDLEWARE                                   ####
#### Copyright (C) 2010-2015 BareMetal Networks Corporation   ####
##################################################################
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###############################################################################
#### Switchyard is the API of Emergence and the only component that is exposed
#### to the internet, client daemons connect and upload logfiles and download
#### configurations and ban lists
###############################################################################
=end

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')

$VERSION = '0.3.0'; $DATE = '11/15/15'
require 'rubygems'
require 'thin'
require 'rack'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'logger'
require 'sinatra/base'
require 'connection_pool'
require 'mongo'
require 'mongoid'
require 'json'
#require 'msg_pack'
require 'pp'
require 'sidekiq'
require 'sidekiq/api'
require 'sidekiq/web'
#require 'bson_ext'
require 'bson'

# bundle exec sidekiq -r ./reserver.rb
#### Installation
## apt-get install libmyslclient18 libmysqlclient18-dev
## Gem install mysql2 hiredis rspec rspec-core shoulda-matchers shoulda mongoid mongo redis
# gem install sidekiq

ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
  $:.unshift File.join(ROOT, folder)
end 
### worker should be required by the above statement
#require_relative 'lib/workers/db_worker.rb'

p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Middleware: #{File.basename(__FILE__)}"
# Use jruby with threaded servers, possible even not because its great at long running apps
# Benchmark everything

$logger = Logger.new('switchyard.log', 'w')


#Mongoid.database = Mongo::Connection.new($options[:mongoDBHost].db($options[:mongoDBCollection]))

=begin
Mongoid.configure do |config|
	name = $options[:mongoDBCollection]
	host = $options[:mongoDBHost]
	config.master = Mongo::Connection.new.db(name)
	config.persist_in_safe_mode = false

end
=end


$TITLE = 'Emergence'

class User
	include Mongoid::Document
    # store_in database: -> { Thread.current[:database] } # good for multitenet apps

	field :username #, :string
	field :email #, :string
	
end

class Machine
	include Mongoid::Document

    field :uuid #, :string
    field :hostname #, :string

    has_many :instances

end

class Instance
	include Mongoid::Document

	field :uuid #, :string
	field :type #, :string
	# field :url, type: Hash

 end

class SwitchyardServ < Sinatra::Base
  get '/' do
  "
 <p>######################## ADI ##########################</p>
  <p>#          ADAPTIVE DEFENSE INFRASTRUCTURE            #</p>
 <p>#######################################################</p>
 <p>##########  Switchyard RESTful API Server  ############</p>
<p>#######################################################</p>
 <p>#v#{$VERSION} Codename: She's Thin, With A Great Rack!#</p>
 <p>#######################################################</p>
 ".to_json
  end

  get '/sidekiqer' do
    stats = Sidekiq::Stats.new
    workers = Sidekiq::Workers.new
    "
    <p>Processed: #{stats.processed}</p>
    <p>Enqueued: #{workers.size} </p>
    <p><a href='/sidekiquer'</a></p>
    <p><a href='/add_job'>Add Job</a></p>
    <p><a href='/sidekiq'>Dashboard</a></p>
    "
  end

  get '/add_job' do
  	"
  	<p>Added Job: #{SwitchWorker.perform_async(20)} </p>
  	<p><a href='/sidekiqer'>Back</a></p>
  	"
  end

  get "/config" do
    #instance.attributes
  end

  post "/machineid" do
    Machine.new(uuid: params[:machineid])
  end

  get '/instances' do

  end

  post "/logs" do
    logfile = params[:logfile]
    instanceType = params[:instancetype]
    instanceID = params[:instanceid]
    machineID = params[:machineid]



    
  end




end


#run! if __FILE__ == $0