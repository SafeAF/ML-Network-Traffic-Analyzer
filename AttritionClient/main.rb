#!/usr/bin/env ruby -w

$:.unshift File.join(File.dirname(__FILE__))

#require 'digest'
require 'net/https'
require 'net/http/persistent'
require 'logger'
require 'yaml'
require 'inline'
require 'json'

class String
	def to_hex
		return nil if self.nil?
		ret = ""
		for i in (0..self.length)
			unless self[i].nil?
				ret += self[i].to_s(16)
			end
		end
		ret
	end
end

class FileError < StandardError; end

class Core
attr_writer :elogger, :logger

def initialize
	@elogger = Logger.new($OPT[:error_log], 'weekly')
	@elogger.level = Logger::WARN

	@logger = Logger.new($OPT[:log_file], 'weekly')
	@logger.level = Logger::WARN
end

def clean(array)
	array.collect { |x| x.chomp! }
	array.collect { |x| x.chomp! }
	array.collect { |x| x.gsub!(/[^\d|\.]/, '') }
	array.uniq!
	array.compact!
	return array
end

def timebox
	a = Time.now.to_s.split(/ /)
	a[3]
end

def splitify(str, pat)
	str.split(/#{pat}/)
end

#alias split_on_pattern, splitify

# def load_log_file(location)
# 	begin
# 	if FileTest.exists? location && FileTest.
# 		log = File.open(location, 'r')
# 		if log.nil?
# 			log.close
# 			return nil
# 		elsif log.respond_to?("each")
# 			logs = []
# 			log.each {|entry| logs.push(entry)}
# 			log.close
# 			return logs
# 		else
# 			log.close
# 			@elogger.warn(get_time + '(WARNING) ' +
# 				'Error with logfile at #{location}')
# 			return nil
# 		end

#     rescue => err
#     	raise FileError
#     end
#   end
end



    uri = URI 'http://localhost:9292/'

    http = Net::HTTP::Persistent.new 'my_app_name'

    # perform a GET
    req = http.request uri
    p req
    p req.body

    # create a POST
   # post_uri = uri + 'create'
   #post = Net::HTTP::Post.new post_uri.path
    #post.set_form_data 'some' => 'cool data'

    # perform the POST, the URI is always required
   # response = http.request post_uri, post

    # if you are done making http requests, or won't make requests for several
    # minutes
    http.shutdown
