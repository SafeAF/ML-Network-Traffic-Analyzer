require 'mongoid/grid_fs'
grid_fs.put(file_path) - to put file in GridFS
grid_fs.get(id) - to load file by id
grid_fs.delete(id) - to delete file
require 'mongoid/grid_fs'

class FileContainer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :grid_fs_id, type: String
end

file = File.open(xls_file_path)

grid_fs   = Mongoid::GridFs
grid_file = grid_fs.put(file.path)

FileContainer.new.tap do |file_container|
  file_container.grid_fs_id = grid_file.id
  file_container.save
end
grid_fs = Mongoid::GridFs
f = grid_fs.put(readable)

grid_fs.get(f.id)
grid_fs.delete(f.id)

g = grid_fs.get(f.id)
g.data # big huge blob
g.each { |chunk| file.write(chunk) } # streaming write

##############

def assert
  raise "Failed!" unless yield
end

require 'mongo'
include Mongo

host = ENV['MONGO_RUBY_DRIVER_HOST'] || 'localhost'
port = ENV['MONGO_RUBY_DRIVER_PORT'] || MongoClient::DEFAULT_PORT

puts "Connecting to #{host}:#{port}"
db = MongoClient.new(host, port).db('ruby-mongo-examples')

data = "hello, world!"

grid = Grid.new(db)

# Write a new file. data can be a string or an io object responding to #read.
id = grid.put(data, :filename => 'hello.txt')

# Read it and print out the contents
file = grid.get(id)
puts file.read

# Delete the file
grid.delete(id)

begin
  grid.get(id)
rescue => e
  assert {e.class == Mongo::GridError}
end

# Metadata
id = grid.put(data, :filename => 'hello.txt', :content_type => 'text/plain', :metadata => {'name' => 'hello'})
file = grid.get(id)

p file.content_type
p file.metadata.inspect
p file.chunk_size
p file.file_length
p file.filename
p file.data