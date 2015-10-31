=begin
##################################################################
#### ADAPTIVE DEFENSE INFRASTRUCTURE -- ADI v0.2.0 10-23-15   ####
#### SWITCHDEMO  MIDDLEWARE                                   ####
#### Copyright (C) 2010-2015 BareMetal Networks Corporation   ####
##################################################################

###############################################################################
#### Switchyard is the API of Emergence and the only component that is exposed
#### to the internet, client daemons connect and upload logfiles and download
#### configurations and ban lists
###############################################################################
=end

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')
$VERSION = '0.2.1'
$DATE = '07/15/15'
require 'rubygems'
require 'thin'
require 'rack'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'logger'
require 'sinatra/base'
require 'connection_pool'
require 'active_record'
require 'mysql2'
require 'pp'
require 'ruby-fann'

#### Installation
## apt-get install libmyslclient18 libmysqlclient18-dev
## Gem install mysql2
## gem install hiredis

ROOT = File.join(File.dirname(__FILE__), '..')

['../app/models/' '../lib', '../db', 'lib/*'].each do |folder|
	$:.unshift File.join(ROOT, folder)
end

p "######################## ADI ##########################"
p "#          ADAPTIVE DEFENSE INFRASTRUCTURE            #"
p "#######################################################"
p "##########  SwitchDEMO RESTful API Server  ############"
p "#######################################################"
p "#v#{$VERSION} Codename:Learn You a Ruby For Very Good!#"
p "#######################################################"

p "#{Time.now}:#{self.class}:IP##{__LINE__}: Booting Switchyard Middleware: #{File.basename(__FILE__)}"
# Use jruby with threaded servers, possible even not because its great at long running apps
# Benchmark everything


### Required for ActiveRecord magick -- Include ALL models
### Don't forget to include app/models/user from kimberlite to
### lend user model and authorize functions
# require '../app/models/instance.rb'
# require '../app/models/user.rb'
# require '../app/models/machine.rb'
# rvm use '1.9.3'


$logger = Logger.new('switchyard.log', 'w+')

$options = Hash.new
$options[:host] = '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5
#if ARGV[1].? '--db-config'
#ActiveRecord::Base.$logger = Logger.new('log/db.log')
#ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))
#end
# ActiveRecord::Base.logger = Logger.new('db.log')
# #ActiveRecord::Base.establish_connection(:development)
# ActiveRecord::Base.establish_connection(
# 		:adapter => 'mysql2',
# 		:database => 'emergence',
# 		:username => 'emergence',
# 		:password => '#GDU3im=86jDFAipJ(f7*rTKuc',
# 		:host => 'datastore2')


$TITLE = 'Emergence'

#  Add methods to Enumerable, available in Array
module Enumerable
 
  def sum
    return self.inject(0){|acc,i|acc +i}
  end
 
  def mean
    return self.sum/self.length.to_f
  end
 
  def variance
    avg=self.mean
    sum=self.inject(0){|acc,i| acc + (i-avg)**2}
    return sum/(self.length - 1).to_f
  end
 
  def std
    return Math.sqrt(self.variance)
  end
 
end  #  module Enumerable

class Bloodlust
	attr_accessor :bloodlust

	def normalize_dataset(raw_data, mean, std)
	 raw_data.map! { |entry| Math.atan(((entry - mean)).abs / std) }
	end

	def format_dataset(input_data)
	 dataset = []
	 desired_output = []
	#p input_data
	 # chop off the numerical data elements 9-13
	 #TODO  check to make sure this is right!
	 dataset = input_data.slice(9,12)

	 raw_desired_output = input_data.pop
	 dataset.map! {|x| x.to_f}

	 desired_output.push raw_desired_output.to_i
	 return dataset, desired_output
	end

	#make configurable
	def train_bloodlust(inputs, desired_outputs) 
	 p "[NEURAL] - Training now"
	 training_data = RubyFann::TrainData.new(
		:inputs => inputs,
		:desired_outputs => desired_outputs)

	 p "[NEURAL] - Training complete"

	 bloodlust = RubyFann::Standard.new(
		:num_inputs => 13,
		:hidden_neurons => [80], # investigate this
		:num_outputs => 1)

	 bloodlust.train_on_data(training_data, 1000, 1, 0.01)
	 return bloodlust
	end


	def format_for_neural(formattee)
	 formatted = []
	  formattee.each  do |entry|
	   	temp = []
	 	entry.each { |y| temp.push y.to_f }
		 formatted.push(temp)
	  end
	 formatted
	end

	def load_training_data(filename)
	 raw_data = []
	 file = File.open(filename)
	 while(line = file.gets) do
	 	line.chomp!
		ary = line.split(',')
		raw_data.push(ary)
	 end
	 return raw_data
	end

	def train_nn
		dataset_location = '../../datasets/training-01.dat'

		dataset = []
		desired_outputs = []
		raw_dataset = load_training_data(dataset_location)

		lambda_prepro = Proc.new { |x| normalize_dataset(x, x.mean, x.std) }

		raw_dataset.each do |dim|
			data, raw_desired_outputs = format_dataset(dim)
			normalized_data = lambda_prepro.call(data)
			dataset.push(normalized_data)
			desired_outputs.push(raw_desired_outputs)
		end

		training_data = RubyFann::TrainData.new(
				:inputs => dataset,
				:desired_outputs => desired_outputs)

		@bloodlust = RubyFann::Standard.new(
				:num_inputs => 12,
				:hidden_neurons => [80], # investigate this
				:num_outputs => 1)

		@bloodlust.train_on_data(training_data, 10, 1, 0.01)
		#@bloodlust.train_on_data(training_data, 10, 1, 0.01)
	end



	def run_blood(input)
		input_ary = input.split(',')
		input_ary.collect! {|i| i.to_f}
		output = @bloodlust.run(input_ary)
	end
end


module Emergence



	class SwitchyardAPI < Sinatra::Base
		#attr_reader :user_obj
		attr_accessor :bloodlust

		def initialize
			p "#{Time.now}:#{self.class}:IP##{__LINE__} Handling request: RESTFUL API: Class #{self.class}" if $DBG

			@bloodlust = Bloodlust.new()
			@bloodlust.train_nn
		end

		def machine_learning_demo(request)
			query = request.query

			# @bloodlust.run_blood()
			if query
				pcap = query[:pcap_log] if query[:pcap_log]
				#pcap_inputs = pcap.split("\n")
				pcap_inputs = JSON.parse(pcap)
				logs = query[:log] if query[:log]

				pcap_inputs.each do |packet|
					header, features = packet.split("~~")
					features_str = features.to_s
					red = Hash.new
					red[:time], red[:src], red[:dst], red[:sport], red[:dport] = header.split('::')
					red[:features] = features_str
					$logger.info "#{Time.now} - Pushing packet SRC:#{red[:src]}:#{red[:sport]}
DST:#{red[:dst]}:#{red[:dport]}"
					@blood = Bloodlust.new
					@blood.train_nn
					@returns = @blood.run_blood(red[:features])
				end

	         @returns
			end
		end




	############


	end

end
## 700 is switchyard return code space




begin
	### Switchyard is the protected class
	class DemoAPI < Sinatra::Base
		attr_accessor :user_obj
		configure do
		set :server, :thin
		set :port, 3000
		set :environment, :production
		end
		#before do ; expires 300, :public, :must_revalidate ;end # before filter use instead of in method, protip

		def initialize
			$logger.info "#{Time.now}:#{self.class}:IP##{__LINE__}: Received request"
		end

		get '/' do
			p 'Emergence API'
			$logger.info "Got request"
		end

		post '/demo' do
		#	p 'Posted' + "#{params[:pcap_log]}"
		#	p request
		nn = Emergence::SwitchyardAPI.new
		nn.machine_learning_demo(request)
		end

		get '/config' do
			$DBG = false
			pp env if $DBG
			#cache_control :public; "cache it"
			ret = {}
			ret[:body] = 'config/ route'
			#sw = SwitchyardAPI.new
			#ret[:body] = sw.get_config(params, @user_obj)

			#if params.has_key?('gucid')foo
			#'Hey there'
			#  status, response = generate_response(params)
			#  if
			#end
		end

		post '/logs' do
			$DBG = false
			pp env if $DBG
			ret = {}
		#	@sw = SwitchyardAPI.new
		#	ret[:body] = sw.handle_log_submit(request)
			ret[:body] = 'logs/ submit'
		end



	end

rescue => err
	pp err.inspect
end


def shut_down
	$logger.info "Shutdown in progress please wait"
	sleep 1
	exit
end

Signal.trap("INT"){
	$logger.info "PID #{Process.pid} Caught Sigint"
	shutdown
}

Signal.trap("TERM") {
	raise "PID #{Process.pid} Caught Sigterm"
}




__END__



class DeferrableBody
  include EventMachine::Deferrable

  def call(body)
    body.each do |chunk|
      @body_callback.call(chunk)
    end
  end

  def each &blk
    @body_callback = blk
  end

end

class AsyncApp

  # This is a template async response. N.B. Can't use string for body on 1.9
  AsyncResponse = [-1, {}, []].freeze

  def call(env)

    body = DeferrableBody.new

    # Get the headers out there asap, let the client know we're alive...
    EventMachine::next_tick { env['async.callback'].call [200, {'Content-Type' => 'text/plain'}, body] }


    # Semi-emulate a long db request, instead of a timer, in reality we'd be
    # waiting for the response data. Whilst this happens, other connections
    # can be serviced.
    # This could be any callback based thing though, a deferrable waiting on
    # IO data, a db request, an http request, an smtp send, whatever.
    EventMachine::add_timer(1) {
      body.call ["Woah, async!\n"]

      EventMachine::next_tick {
        # This could actually happen any time, you could spawn off to new
        # threads, pause as a good looking lady walks by, whatever.
        # Just shows off how we can defer chunks of data in the body, you can
        # even call this many times.
        body.call ["Cheers then!"]
        body.succeed
      }
    }

    # throw :async # Still works for supporting non-async frameworks...

    AsyncResponse # May end up in Rack :-)
  end

  # The additions to env for async.connection and async.callback absolutely
  # destroy the speed of the request if Lint is doing it's checks on env.
  # It is also important to note that an async response will not pass through
  # any further middleware, as the async response notification has been passed
  # right up to the webserver, and the callback goes directly there too.
  # Middleware could possibly catch :async, and also provide a different
  # async.connection and async.callback.

end

## TODO ##
# Migrate training out of here back to bloodlust, this is horrible design, tight coupling like they are humping
# Ditch webrick for thin cluster
# Ditch drb for redis queque

  #use Rack::Auth::Basic, $TITLE  do |user, pass|
  #  @usar = User.authenticate(user, pass)
    # user == 'foo' && password == 'bar'




if $0 == __FILE__ then
p "[+] Starting Distrubted Ruby Service"
DRb.start_service
$apache_mod = DRbObject.new nil, 'druby://localhost:11000'
p "[+] Training the Neural Network..."
$apache_mod.train_nn
p "[+] Training complete"

ROOT = Dir.getwd
class Server
  def default_options
    super.merge({
  :port         => "7000",
  :ip           => "0.0.0.0",
  :environment  => (ENV['RAILS_ENV'] || "development").dup,
  :daemonize => true,
  :daemonize => true,
  :pid => File.absolute_path("/tmp/pids/sw0.pid"),
  :config => File.expand_path("config/switch.yaml"),
  :SSLEnable => true,
  :ssl => true,
  "ssl-verify" => true,
  "ssl-key-file" => File.expand_path("config/certs/server.key"),
  "ssl-cert-file" => File.expand_path("config/certs/server.crt"),

})
#  :server_root  => File.expand_path(ROOT + "/public/"),
#  :pkey         => OpenSSL::PKey::RSA.new(
#                      File.open(ROOT + "/config/certs/server.key").read),
#  :cert         => OpenSSL::X509::Certificate.new(
#                      File.open(ROOT + "/config/certs/server.crt").read),
#  :server_type  => WEBrick::SimpleServer,
#  :charset      => "UTF-8",
#  :mime_types   => WEBrick::HTTPUtils::DefaultMimeTypes,
 # :debugger     => false


#ENV["RAILS_ENV"] = OPTIONS[:environment]
#RAILS_ENV.replace(OPTIONS[:environment]) if defined?(RAILS_ENV)

  server = WEBrick::HTTPServer.new(
      :Port             => options[:port].to_i,
      :ServerType       => options[:server_type],
      :BindAddress      => options[:ip],
      :SSLEnable        => true,
      :SSLVerifyClient  => OpenSSL::SSL::VERIFY_NONE,
      :SSLCertificate   => options[:cert],
      :SSLPrivateKey    => options[:pkey],
      :SSLCertName      => [ [ "CN", WEBrick::Utils::getservername ] ]

    )



server.mount "/submit", HandlePost, options
server.mount "/retrieve", HandleGet, options
server.mount "/chkupdate", CheckUpdate, options
server.mount "/getbans", GetBans, options
