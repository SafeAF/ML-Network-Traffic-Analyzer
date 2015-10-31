#!/usr/bin/env ruby


require 'uri'
require 'net/http'
require 'json'




$options = Hash.new
$options[:host] = 'localhost'
$options[:port] = '7000'
$options[:user] = 'foo'
$options[:pass] = 'bar'
$options[:version] = 'submit-harness-pre-0.2.0'
$options[:cid] = 'cid400f0sfs053353325235325235'
$options[:retry] = 5
$options[:httpVerb] = ARGV[0]
$options[:requestURI] = ARGV[1]
$options[:payload] = ARGV[2]

class Instance
	attr_accessor :log_location, :pcap_location, :strace_location,
	              :instance_type, :status, :gucid, :ban_duration,
	              :hostname, :pcap_port, :pcap_filter, :pcap_interface,
	              :pcap_thread_flag, :message, :stats_log, :stats_pcap,
	              :monitor_log, :monitor_pcap, :sniffer_thread, :uri,
	              :http, :req, :response

	def initialize()
		@gucid = 'APACHE_fdfakljlkrj3r34304835rklj'
		@instance_type = 'APACHE'
		@pcap_thread_flag = 0
#		@hostname = Socket.gethostname
		@message = ""

		end

		def submit_to_switchyard(logfile=nil, pcapfile)

			begin
				@uri = URI.parse('http://' + $options[:host] + ':' +
						                $options[:port] + '/demo')

				@http = Net::HTTP.new(@uri.host, @uri.port)
				@req = Net::HTTP::Post.new(@uri.path)
			#	@http.use_ssl = true
				@req.basic_auth $options[:user], $options[:pass]
				@req.set_form_data({
						                  'user' => $options[:user],
						                  'pass' => $options[:pass],
						                  #				'instances_installed' => @instances.keys.join('--'),
						                  'platform' => RUBY_PLATFORM,
						                  'instance_type' => self.instance_type,
						                  'hostname' => self.hostname,
						                  'client_version' => $options[:version],
						                  'gucid' => self.gucid,
						                  'cid' => $options[:cid],

						                  'log' => logfile,
						                  'pcap_log' => pcapfile,
				                  } )
				@response = @http.request(@req)
				return @response.body

			rescue Exception => err
				print "[#{Time.now}] Error: Exception #{err.inspect}"
				puts "[#{Time.now}] Error: Backtrace #{err.backtrace}"
				sleep $options[:retry]
				retry
			end
		end

		def get_request(path)
			begin
				@uri = URI.parse('http://' + $options[:host] + ':' +
						                $options[:port] + "#{path}")

				@http = Net::HTTP.new(@uri.host, @uri.port)
				@http.start() do |http|
					@req = Net::HTTP::Get.new("#{path}")
					@req.basic_auth $options[:user], $options[:pass]
					@response = @http.request(req)
				end



				return @response.body

			rescue Exception => err
				print "[#{Time.now}] Error: Exception #{err.inspect}"
				puts "[#{Time.now}] Error: Backtrace #{err.backtrace}"
				sleep $options[:retry]
				retry
			end

		end
end



begin

logfile = nil

	exploit = 	"1::08:41:09::72.14.213.102::10.0.0.7::80::34392~~~474554202f7361666562726f7773696e672f72642f4368466e6232396e4c58426f61584e6f4c584e6f59585a6863684141474a334c43434377797767714236416c4167445f5f774579425a306c4167414820485454502f312e31da486f73743a207361666562726f7773696e672d63616368652e676f6f676c652e636f6dda557365722d4167656e743a204d6f7a696c6c612f352e3020285831313b20553b204c696e7578207838365f36343b20656e2d55533b2072763a312e392e302e313929204765636b6f2f323031303132303932332049636577656173656c2f332e302e36202844656269616e2d332e302e362d3329da4163636570743a20746578742f68746d6c2c6170706c69636174696f6e2f7868746d6c2b786d6c2c6170706c69636174696f6e2f786d6c3b713d302e392c2a2f2a3b713d302e38da4163636570742d4c616e67756167653a20656e2d75732c656e3b713d302e35da4163636570742d456e636f64696e673a20677a69702c6465666c617465da4163636570742d436861727365743a2049534f2d383835392d312c7574662d383b713d302e372c2a3b713d302e37da4b6565702d416c6976653a20333030da436f6e6e656374696f6e3a206b6565702d616c697665da436f6f6b69653a2053533d44514141414b3441414144773855457549793161525a77446a7750464e4233374938772d2d414561734157426f586f306a726a4b344734326e59705937713343446c3435324f694d4752444e6c4d384e4f4953445137476656767066742d4347787574356b73554c7a4f5132745949644c6d4950366a74327a755245516945703875726e574970307332577a48556d677641325f5f535a50437472435372635743356866766f75776f306f7831764441305f43676f5f6a6c474454716d4378374b65375673476a4837416f62596630386e77634e476f523639346a52777574763548426b6b565f464578684a7a7036727630513435773b205349443d44514141414b3441414141314971786832676e7542635f537459756e4879475f4b4f716c6a5032516655375f756a5a6e785f796c426f45665144765f696679457275763467693039526d484b33682d475a786f373676344344715577396a525267786b355a4a30692d596a55395f75774b78564966594254384f7053557535445f5f525771507a6d637646357042634b6969323755427830634e70324d5937317051644651346358326d774874795f466f637a53306e7455304e6e304350354856514a624f6d76693641463467396762306557795944386e336f42576d624f6968506d4b44565146553332694732477a75677a7838673b2072656d656d6265726d653d747275653b20505245463d49443d613463623939626331663732633937653a553d393334396135373132346361393264393a46463d303a544d3d313239313536353331373a4c4d3d313239343534343231393a474d3d313a533d744744736b333363676953586d7254323b205736443d76343d303a64733d303a773d313a6c3d2d3136353a713d303b204e49443d34373d634d7141614d7343423645644e4368715a31546f59746764524b4437704367705455796c6d303743777a316d6e416f4152542d68683457617956776d4b516d4c474b5a437475306d5052764d657063712d5f2d325142396d325171705a333873446d73786f4a46514f51696643585935544f47774934695f554f694d717a7a383b20485349443d41526b652d4f614f65725745504a624c73dada"

	payload = ARGV[2] || exploit
		i = Instance.new

		if ARGV[0].include? 'post'
		p	i.submit_to_switchyard(logfile, payload)

		elsif ARGV[0].include? 'get'
			i.get_request(ARGV[1])

		end


rescue => err
	   p "#{Time.now} Error Inspect: #{err.inspect}"
	   p "#{Time.now} Error Backtrace: #{err.backtrace}"
	   p "-----------------------------------------------------------------"
end

