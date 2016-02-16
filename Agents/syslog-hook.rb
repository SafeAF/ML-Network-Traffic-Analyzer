require 'socket'
require 'uri'
require 'json'
class SyslogTransport; end
## PEEP OUT ->
# Logster in general as a log viewer
# Logster ignore_pattern.rb

FACILITIES = %w{
		kern
		user
		mail
		daemon
		auth
		syslog
		lpr
		news
		uucp
		cron
		authpriv
		ftp
		local0 local1 local2 local3 local4 local5 local6 local7
	}

SEVERITIES = %w{
		emerg
		alert
		crit
		err
		warning
		notice
		info
		debug
	}



# Read syslog messages from one or more sockets, and send it to a logstash
# server.
#
class SyslogTransport
  def initialize(sockets, servers)
    @writer = LogstashWriter.new(servers)

    @readers = sockets.map { |f, tags| HookLogSocket.new(f, tags, @writer) }
  end

  def run
    #@writer.run
    @readers.each { |w| w.run }

    @writer.wait
    @readers.each { |w| w.wait }
  end
end

module SyslogTransport::Worker
  # If you ever want to stop a reader, here's how.
  def stop
    if @worker
      @worker.kill
      @worker.join
      @worker = nil
    end
  end
  # If you want to wait for a reader to die, here's how.
  #
  def wait
    @worker.join
  end

  private

  def debug
    if ENV['DEBUG_SYSLOGTRANSPORT']
      puts "#{Time.now.strftime("%F %T.%L")} #{self.class} #{yield.to_s}"
    end
  end
end

class SyslogTransport::HookLogSocket
  include SyslogTransport::Worker

  def initialize(file, tags, destServers)
    @file, @tags, @destServers = file, tags, @destServers
  end

  def run
    debug { "#run called" }

    begin
      socket = Socket.new(Socket::AF_UNIX, Socket::SOCK_DGRAM, 0)
      socket.bind(Socket.pack_sockaddr_un(@file))
    rescue Errno::EEXIST
      File.unlink(@file)
      retry
    rescue SystemCallError
      $stderr.puts "Error while trying to bind to #{@file}"
      raise
    end

    @worker = Thread.new do
      begin
        loop do
          msg = socket.recvmsg
          debug { "Message received: #{msg.inspect}" }
          process_message msg.first.chomp
        end
      ensure
        socket.close
        File.unlink(@file) rescue nil
      end
    end
  end
end

  private

  def  process_message(msg)
    p "#{msg}"
  end

private

def process_message(msg)
  if msg =~ /^<(\d+)>(\w{3} [ 0-9]{2} [0-9:]{8}) (.*)$/
    flags     = $1.to_i
    timestamp = $2
    content   = $3

    # Add in more schemas, liek application specfic ie rails
    hostname, program, pid, message = case content
                                        # the gold standard: hostname, program name with optional PID
                                        when /^([a-zA-Z0-9_-]*[^:]) (\S+?)(\[(\d+)\])?: (.*)$/
                                          [$1, $2, $4, $5]
                                        # hostname, no program name
                                        when /^([a-zA-Z0-9_-]+) (\S+[^:] .*)$/
                                          [$1, nil, nil, $2]
                                        # program name, no hostname (yeah, you heard me, non-RFC compliant!)
                                        when /^(\S+?)(\[(\d+)\])?: (.*)$/
                                          [nil, $1, $3, $4]
                                        else
                                          # I have NFI
                                          [nil, nil, nil, content]
                                      end

    severity = flags % 8
    facility = flags / 8

    logEntry = create_log_entry(
        syslog_timestamp: timestamp,
        severity:         severity,
        facility:         facility,
        hostname:         hostname,
        program:          program,
        pid:              pid,
        message:          message,
    ).to_json

    @logstash.send_entry(logEntry)
  else
    $stderr.puts "Unparseable message: #{msg}"
  end
end

def create_log_entry(h)
  {}.tap do |e|
    e['@version']   = '1'
    e['@timestamp'] = Time.now.utc.strftime("%FT%T.%LZ")

    h['facility_name'] = FACILITIES[h[:facility]]
    h['severity_name'] = SEVERITIES[h[:severity]]

    e.merge!(h.delete_if { |k,v| v.nil? })

    e[:pid] = e[:pid].to_i if e.has_key?(:pid)

    e.merge!(@tags) if @tags.is_a? Hash

    debug { "Log entry is: #{e.inspect}" }
  end
end



# Write messages to one of a collection of logstash servers.
#
class Syslogstash::LogstashWriter
  include Syslogstash::Worker

  # Create a new logstash writer.
  #
  # Give it a list of servers, and your writer will be ready to go.
  # No messages will actually be *delivered*, though, until you call #run.
  #
  def initialize(servers)
    @servers = servers.map { |s| URI(s) }

    unless @servers.all? { |url| url.scheme == 'tcp' }
      raise ArgumentError,
            "Unsupported URL scheme: #{@servers.select { |url| url.scheme != 'tcp' }.join(', ')}"
    end

    @entries = []
    @entries_mutex = Mutex.new
  end

  # Add an entry to the list of messages to be sent to logstash.  Actual
  # message delivery will happen in a worker thread that is started with
  # #run.
  #
  def send_entry(e)
    @entries_mutex.synchronize { @entries << e }
    @worker.run if @worker
  end

  # Start sending messages to logstash servers.  This method will return
  # almost immediately, and actual message sending will occur in a
  # separate worker thread.
  #
  def run
    @worker = Thread.new { send_messages }
  end

  private

  def send_messages
    loop do
      if @entries_mutex.synchronize { @entries.empty? }
        sleep 1
      else
        begin
          entry = @entries_mutex.synchronize { @entries.shift }

          current_server do |s|
            s.puts entry
          end

          # If we got here, we sent successfully, so we don't want
          # to put the entry back on the queue in the ensure block
          entry = nil
        ensure
          @entries_mutex.synchronize { @entries.unshift if entry }
        end
      end
    end
  end

  # *Yield* a TCPSocket connected to the server we currently believe to
  # be accepting log entries, so that something can send log entries to
  # it.
  #
  # The yielding is very deliberate: it allows us to centralise all
  # error detection and handling within this one method, and retry
  # sending just be calling `yield` again when we've connected to
  # another server.
  #
  def current_server
    # I could handle this more cleanly with recursion, but I don't want
    # to fill the stack if we have to retry a lot of times
    done = false

    until done
      if @current_server
        begin
          debug { "Using current server" }
          yield @current_server
          done = true
        rescue SystemCallError => ex
          # Something went wrong during the send; disconnect from this
          # server and recycle
          debug { "Error while writing to current server: #{ex.message} (#{ex.class})" }
          @current_server.close
          @current_server = nil
          sleep 0.1
        end
      else
        begin
          # Rotate the next server onto the back of the list
          next_server = @servers.shift
          debug { "Trying to connect to #{next_server.to_s}" }
          @servers.push(next_server)
          @current_server = TCPSocket.new(next_server.host, next_server.port)
        rescue SystemCallError => ex
          # Connection failed for any number of reasons; try again
          debug { "Failed to connect to #{next_server.to_s}: #{ex.message} (#{ex.class})" }
          sleep 0.1
          retry
        end
      end
    end
  end
end


