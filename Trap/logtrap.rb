require 'socket'


def run

	begin
		socket = Socket.new(Socket::AF_UNIX, Socket::SOCK_DGRAM, 0)
		socket.bind(Socket.pack_sockaddr_un(@file))
	rescue Errno::EEXIST, Errno::EADDRINUSE
		log { "socket file #{@file} already exists; deleting" }
		File.unlink(@file) rescue nil
		retry
	rescue SystemCallError
		log { "Error while trying to bind to #{@file}" }
		raise
	end

	@worker = Thread.new do
		begin
			loop do
				msg = socket.recvmsg
				debug { "Message received: #{msg.inspect}" }
				@metrics.received(@file, Time.now)
				process_message msg.first.chomp
				relay_message msg.first
			end
		ensure
			socket.close
			log { "removing socket file #{@file}" }
			File.unlink(@file) rescue nil
		end
	end
end

run
