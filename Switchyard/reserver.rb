
$TITLE = 'EMERGENT ATTRITION INFRASTRUCTURE'

#class SwitchyardServ < Sinatra::Application

#include Rack::Builder
#include Rack::Utils


# configure :development do
# 	enable :logging, :dump_errors, :inline_templates
# 	enable :methodoverride
# 	set :root, File.dirname(__FILE__)
# 	logger = Logger.new($stdout)

# 	Mongoid.configure do |config|
# 		config.logger = logger
# 		config.persist_in_safe_mode = false
# 	end
# end

#end
set :server, :thin
set :root, File.dirname(__FILE__)
enable :methodoverride
enable :logging

## Helpers
helpers do 
	def json_parse_post_body
		JSON.parse(request.body)
	end
end

########################################################################
## Data Models

class User
	include Mongoid::Document
    # store_in database: -> { Thread.current[:database] } # good for multitenet apps
    # foo = Foo.where(name: "Foo").between(age: 18..25).first
    # foo.bar.create(name: "Bazzle")
    # foo.with(database: "foos", session: "backup").save!
	field :username, type: String
	field :email, type: String
	field :encrypted_password, type: String	
end

class Machine
	include Mongoid::Document

    field :uuid, type: String
    field :hostname, type: String

    has_many :instances

end

class Instance
	include Mongoid::Document

	field :uuid #, :string
	field :type #, :string
	field :subscribed, type: Boolean
	# field :url, type: Hash

 end

 class Conf
 	include Mongoid::Document
   
    field :logfile

 end

class SwitchWorker
	include Sidekiq::Worker
     sidekiq_options :queue => :switchyard
	def perform(input)
		#$redis.push(input)
		$SHMEM.push(input)
		#sleep input
	end

	
end




#########################################################################
# Main App
#########################################################################
class SwitchyardServ < Sinatra::Base


  # before do
  # 	content_type :txt
  # end

  before do
  	content_type :json

  end

  get '/' do
   		  "
 <p>######################## ADI ##########################</p>
  <p>#            #{$TITLE}              #</p>
 <p>#######################################################</p>
 <p>##########  Switchyard RESTful API Server  ############</p>
<p>#######################################################</p>
 <p>#v#{$VERSION} Codename: She's Thin, With A Great Rack!#</p>
 <p>#######################################################</p>
 "
 erb :index
  end

   get '/status' do 
     {status: 'up', date: Time.now}.to_json
   end


  get '/sidekiqer' do
    stats = Sidekiq::Stats.new
    workers = Sidekiq::Workers.new
    erb "
    <p>Messages: #{ @messages = $SHMEM.values}</p>
    <p>Processed: #{stats.processed}</p>
    <p>Enqueued: #{workers.size} </p>
    <p>#{url('/sidekiquer')}</p>
    <p><a href='/add_job'>Add Job</a></p>
    <p><a href='/sidekiq'>Dashboard</a></p>
    "
    # run Sidekiq::Web
  end

  get '/add_job' do
  	"
  	<p>Added Job: #{SwitchWorker.perform_async("ip: 1021.24.142.2141, bar: 453")} </p>
  	<p><a href='/sidekiqer'>Back</a></p>
  	"
  end

  get "/config" do 
    #instance.attributes
    ## Get instance where instanceid, and subscribed = true, and on a
    ## machine that is installed too?
    instance = Instance.where(uuid: params[:instanceid])

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

   post '/newmachine' do 
   	#m = Machine.new(params[:machine])
   	m = Machine.new(json_parse_post_body)
   	if m.save
   		 "Machine with id: #{params[:uuid]} was created".to_json
   	else
   		"Error saving machine with id: #{params[:uuid]}".to_json
    end
   end

  get '/halt' do
   'Failure'
   halt 500
  end


  get %r{/(sp|gre)eedy} do
  	pass if request.path =~/\speedy/
  	"Cauhgt in the greedy route"
  end

  get '/speedy/' do
  	"control passed to speedy"
  	redirect '/halt', 301
  end


    


 get '/config/:instance' do |n|
   
   if @instance.save
   	status 201
   	redirect '/' + @contact.id.to_json
   else
   	status 400
   	{status: "Unsubscribed or Unregistered Instance. Please subscribe",
   	 api_version: $VERSION, httpcode: 400}.to_json
 end
end

 get '/machines/*/id' do |n|
  p params['splat'] 
  end

end


#run! if __FILE__ == $0

__END__


@@ layout
<html>
  <head>
    <title>Sinatra + Sidekiq</title>
    <body>
      <%= yield %>
    </body>
</html>

@@ index
  <h1>Sinatra + Sidekiq Example</h1>
  <h2>Failed: <%= @failed %></h2>
  <h2>Processed: <%= @processed %></h2>

  <form method="post" action="/msg">
    <input type="text" name="msg">
    <input type="submit" value="Add Message">
  </form>

  <a href="/">Refresh page</a>

  <h3>Messages</h3>
  <% @messages.each do |msg| %>
    <p><%= msg %></p>
  <% end %>