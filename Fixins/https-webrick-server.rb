require 'openssl'
require 'webrick'
require 'webrick/ssl'

@name = OpenSSL::X509::Name.parse 'CN=localhost/DC=localdomain'

@key = OpenSSL::PKey::RSA.new 1024

@cert = OpenSSL::X509::Certificate.new
@cert.version = 2
@cert.serial = 0
@cert.not_before = Time.now
@cert.not_after = Time.now + 300
@cert.public_key = @key.public_key
@cert.subject = @name
@cert.issuer = @name

@cert.sign @key, OpenSSL::Digest::SHA1.new

@host = 'localhost'
@port = 10082

config = {
    :BindAddress                => @host,
    :Port                       => @port,
    :Logger                     => WEBrick::Log.new(NullWriter.new),
    :AccessLog                  => [],
    :ShutDownSocketWithoutClose => true,
    :ServerType                 => Thread,
    :SSLEnable                  => true,
    :SSLCertificate             => @cert,
    :SSLPrivateKey              => @key,
    :SSLStartImmediately        => true,
}

@server = WEBrick::HTTPServer.new config

@server.mount_proc '/' do |req, res|
  res.body = "ok"
end

@server.start

begin
  TCPSocket.open(@host, @port).close
rescue Errno::ECONNREFUSED
  sleep 0.2
  n_try_max -= 1
  raise 'cannot spawn server; give up' if n_try_max < 0
  retry
end
