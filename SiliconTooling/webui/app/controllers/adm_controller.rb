#require 'file-tail'

class AdmController < ApplicationController
  def index
	@user = User.find(session[:user_id])
  end

  def show_shagg_db
	@shaggDBDump = Shagg.all

 
  end
end


#def tail(file, interval=1)
#   raise "Illegal interval #{interval}" if interval < 0

#   File.open(file) do |io|
#     loop do
#       while ( line = io.gets )
#         puts line
#       end

#       # uncomment next to watch what is happening
#        puts "-"
#       sleep interval
#     end
#   end
#end


