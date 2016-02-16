## BEGIN INIT #####################################################################
require 'connection_pool';require 'redis-objects';require 'mongo';require 'mongoid';require 'sinatra/base'
require 'json'; require 'pp'
require File.expand_path(File.dirname(__FILE__) + '/libtimongo');require File.expand_path(File.dirname(__FILE__) + '/libnetutils')
$options = {};$options[:redhost] = ARGV[0] || '10.0.1.75' ;$options[:redport] = '6379'
$options[:redtable] = 5 ;$options[:mongodb] = 'titan'
$options[:mongoconnector] = ARGV[1] || '10.0.1.30:27017'
Redis::Objects.redis = ConnectionPool.new(size: 15, timeout: 5) {
  Redis.new({host: $options[:redhost], port: $options[:redport], db: $options[:redtable]})}
Mongoid.load!('mongoid.yml', :development)
$MONGO = Mongo::Client.new([$options[:mongoconnector]], :database => $options[:mongodb])
$logger = Mongo::Logger.logger = Logger.new($stdout);Mongo::Logger.logger.level = Logger::INFO
$logger.info  "Connecting to MongoDB @ #{$options[:mongoconnector]}, using database: #{$options[:mongodb]}"
## END INIT ## BEGIN CORE ############################################################
class GridFS

  def get_file(db, id) ; Mongo::Grid.new(db).get(id); end
  def read_file(db, filename); Mongo::GridFileSystem.new(db).open(filename, "r"); end
  def get_file_string(db, fstr); Mongo::Grid.new(db).get(BSON::ObjectId.from_string(fstr.to_s));end
  def remove_files(db, filedb) ; db.collection('fs.files').remove; end

end

module Titan
  module Redis
    class Lists
    attr_accessor :lists, :pshm

    def initialize()
      @@PSHM = Redis::List.new('system:memory', :marshal => true)
    end

    def add(listName)
      @lists.push Redis::List.new(listName, :marshal => true)
    end

    class Mongo < GridFS
      attr_accessor :client, :admin
      attr_accessor :standalone, :replicaSet, :sharded, :singleMongo

      def initialize(client=nil)
        @client = client || Mongo::Client.new([$options[:mongoconnector]], :database => $options[:mongodb])
        @admin = @client['admin']
      end

      # Returns a list of all database names
      def list_all_databases ; @client.database_names; end

      # Returns an hash with names mapped to size
      def list_all_databases_with_size; @client.database_info; end;

      def standalone? ; @standalone ||= @client.cluster.servers.first.standalone? ; end

      def replica_set? ; @replicaSet ||= @client.cluster.replica_set?; end

      def sharded? ; @sharded ||= (@client.cluster.sharded? || single_mongos?); end

      def single_mongos? ; @singleMongo ||= @client.cluster.servers.first.mongos? ;end

      def profiling_level_on
        @admin.profiling_level = :all
      end

      def mongo_methods;  $MONGO.methods.sort - Object.methods; end
      def mongo_database_methods; $MONGO.database.methods.sort - Object.methods; end
      # Delete all documents matching a condition
      ## inputs: collection name, condition hash 'foo' => 'bar'
      def delete_all_matching(collection, condition)
        @client[:collection].find(condition).delete_many
      end
      # Delete one document matching a condition
      # inputs: client[:restaurants].find('borough' => 'Queens').delete_one
      def delete_one_matching(collection, condition)
        @client[collection].find(condition).delete_one
      end

      # Delete all documents in a collection
      def delete_all(collection)
        @client[collection].delete_many
      end

      # Drop a collection
      def drop(collection)
        @client[collection].drop
      end
    end
  end


    Thread.new {
      Thin::Server.start('0.0.0.0', 3333, Class.new(Sinatra::Base) {
                                    get '/logs' do
                                      ret = {}
                                      ret[:foo] = 'bar'
                                      ret[:baz] = 'too'
                                      ret.to_json

                                    end

                                    post '/logs'
                                    ret = {}
                                    @logs = JSON.parse(params[:logfile], :symbolize_names => true)

                                    ret[:foo] = 'success'

                                  })}
  ## should be modular instead
  begin
    class TitanAPI < Sinatra::Base
      attr_accessor :user

      def initialize()
        $logger.info "self.class @IP#{__LINE__} #{caller}"
      end

      get '/' do
        erb :index
      end

      post '/api/vservers/'


      get '/api/operators/*' do
        # matches /api/operators/foo/bar/
        params['splat'] # => ['foo/bar/', 'sh']
      end

      post '/api/upload/*.*' do |path,ext|
        [path, ext] # => ["path/to/file", "xml"]
      end

      get '/api/download/*.*' do
        send_file foundfile
      end

      get '/api/attachment/*.*' do
        attachment "info.txt"
        "store it!"
      end

      ## Short code generator for urls
      helpers do
        include Rack::Utils
        alias_method :h, :escape_html

        def random_string(length)
          rand(36**length).to_s(36)
        end
      end



      post '/' do
        if params[:url] and not params[:url].empty?
          @shortcode = random_string 5
          redis.setnx "links:#{@shortcode}", params[:url]
        end
        erb :index
      end

      get '/:shortcode' do
        @url = redis.get "links:#{params[:shortcode]}"
        redirect @url || '/'
      end



      get '/api/request' do
        t = %w[text/css text/html application/javascript]
        request.accept              # ['text/html', '*/*']
        request.accept? 'text/xml'  # true
        request.preferred_type(t)   # 'text/html'
        request.body                # request body sent by the client (see below)
        request.scheme              # "http"
        request.script_name         # "/example"
        request.path_info           # "/foo"
        request.port                # 80
        request.request_method      # "GET"
        request.query_string        # ""
        request.content_length      # length of request.body
        request.media_type          # media type of request.body
        request.host                # "example.com"
        request.get?                # true (similar methods for other verbs)
        request.form_data?          # false
        request["some_param"]       # value of some_param parameter. [] is a shortcut to the params hash.
        request.referrer            # the referrer of the client or '/'
        request.user_agent          # user agent (used by :agent condition)
        request.cookies             # hash of browser cookies
        request.xhr?                # is this an ajax request?
        request.url                 # "http://example.com/example/foo"
        request.path                # "/example/foo"
        request.ip                  # client IP address
        request.secure?             # false (would be true over ssl)
        request.forwarded?          # true (if running behind a reverse proxy)
        request.env                 # raw env hash handed in by Rack
      end

      get /\A\/api\/([\w]+)\z/ do
        "hello #{params['captures'].first}!"
      end

      get %r{/hello/([\w]+)} do |c|
        # Matches "GET /meta/hello/world", "GET /hello/world/1234" etc.
        "Hello, #{c}!"
      end
    end

  rescue => err
    $logger.error "#{pp err.inspect}"
    $logger.error "#{pp err.backtrace}"
    $logger.error "#{pp caller}"
    $logger.error "#################################################"
  end
end


tim = Titan::Mongo.new $MONGO
tir = Titan::Redis.new

# p ti.list_all_databases
#
#   set :server, :thin
#   connections = []
#
#   get '/subscribe' do
#     # register a client's interest in server events
#     stream(:keep_open) do |out|
#       connections << out
#       # purge dead connections
#       connections.reject!(&:closed?)
#     end
#   end
#
#   post '/:message' do
#     connections.each do |out|
#       # notify client that a new message has arrived
#       out << params['message'] << "\n"
#
#       # indicate client to connect again
#       out.close
#     end
#
#     # acknowledge
#     "message received"
#   end

#ti.profiling_level_on

#$MONGO.coll.find().to_a
#
# # Query for all documents in a collection
#
# cursor = client[:restaurants].find
#
# cursor.each do |doc|
#   puts doc
# end
#
# # Query for equality on a top level field
#
# cursor = client[:restaurants].find('borough' => 'Manhattan')
#
# cursor.each do |doc|
#   puts doc
# end
#
# # Query by a field in an embedded document
#
# cursor = client[:restaurants].find('address.zipcode' => '10075')
#
# cursor.each do |doc|
#   puts doc
# end
#
# # Query by a field in an array
#
# cursor = client[:restaurants].find('grades.grade' => 'B')
#
# cursor.each do |doc|
#   puts doc
# end
#
# # Query with the greater-than operator
#
# cursor = client[:restaurants].find('grades.score' => { '$gt' => 30 })
#
# cursor.each do |doc|
#   puts doc
# end
#
# # Query with the less-than operator
#
# cursor = client[:restaurants].find('grades.score' => { '$lt' => 10 })
#
# cursor.each do |doc|
#   puts doc
# end
#
# # Query with a logical conjuction (AND) of query conditions
#
# cursor = client[:restaurants].find({ 'cuisine' => 'Italian',
#                                      'address.zipcode' => '10075'})
#
# cursor.each do |doc|
#   puts doc
# end
#
# # Query with a logical disjunction (OR) of query conditions
#
# cursor = client[:restaurants].find('$or' => [{ 'cuisine' => 'Italian' },
#                                              { 'address.zipcode' => '10075'}
#                                    ]
# )
#
# cursor.each do |doc|
#   puts doc
# end
#
# # Sort query results
#
# cursor = client[:restaurants].find.sort('borough' => Mongo::Index::ASCENDING,
#                                         'address.zipcode' => Mongo::Index::DESCENDING)
#
# cursor.each do |doc|
#   puts doc
# end
#
# # Group documents by field and calculate count.
#
# coll = client[:restaurants]
#
# results = coll.find.aggregate([ { '$group' => { '_id' => '$borough',
#                                                 'count' => { '$sum' => 1 }
#                                 }
#                                 }
#                               ])
#
# results.each do |result|
#   puts result
# end
#
# # Filter and group documents
#
# results = coll.find.aggregate([ { '$match' => { 'borough' => 'Queens',
#                                                 'cuisine' => 'Brazilian' } },
#                                 { '$group' => { '_id' => '$address.zipcode',
#                                                 'count' => { '$sum' => 1 } } }
#                               ])
#
# results.each do |result|
#   puts result
# end
# require 'date'
#
# result = client[:restaurants].insert_one({
#                                              address: {
#                                                  street: '2 Avenue',
#                                                  zipcode: 10075,
#                                                  building: 1480,
#                                                  coord: [-73.9557413, 40.7720266]
#                                              },
#                                              borough: 'Manhattan',
#                                              cuisine: 'Italian',
#                                              grades: [
#                                                  {
#                                                      date: DateTime.strptime('2014-10-01', '%Y-%m-%d'),
#                                                      grade: 'A',
#                                                      score: 11
#                                                  },
#                                                  {
#                                                      date: DateTime.strptime('2014-01-16', '%Y-%m-%d'),
#                                                      grade: 'B',
#                                                      score: 17
#                                                  }
#                                              ],
#                                              name: 'Vella',
#                                              restaurant_id: '41704620'
#                                          })
#
# result.n #=> returns 1, because 1 document was inserted.
#
# # Update top-level fields in a single document
#
# client[:restaurants].find(name: 'Juni').update_one('$set'=> { 'cuisine' => 'American (New)' },
#                                                    '$currentDate' => { 'lastModified'  => true })
#
# # Update an embedded document in a single document
#
# client[:restaurants].find(restaurant_id: '41156888').update_one('$set'=> { 'address.street' => 'East 31st Street' })
#
# # Update multiple documents
#
# client[:restaurants].find('address.zipcode' => '10016').update_many('$set'=> { 'borough' => 'Manhattan' },
#                                                                     '$currentDate' => { 'lastModified'  => true })
#

# client  = MongoClient.new(host, port)
# db   = client.db('ruby-mongo-examples')
# coll = db.create_collection('test')
#
# # Erase all records from collection, if any
# coll.remove
#
# admin = client['admin']
#
# # Profiling level set/get
# puts "Profiling level: #{admin.profiling_level}"
#
# # Start profiling everything
# admin.profiling_level = :all
#
# # Read records, creating a profiling event
# coll.find().to_agit
#
# # Stop profiling
# admin.profiling_level = :off
#
# # Print all profiling info
# pp admin.profiling_info
#
# # Validate returns a hash if all is well and
# # raises an exception if there is a problem.
# info = db.validate_collection(coll.name)
# puts "valid = #{info['ok']}"
# puts info['result']
#
# # Destroy the collection
# coll.drop