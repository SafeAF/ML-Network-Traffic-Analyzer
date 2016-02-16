require 'net/http/persistent'

store = OpenSSL::X509::Store.new
store.add_cert @cert

@http = Net::HTTP::Persistent::SSLReuse.new @host, @port
@http.cert_store = store
@http.ssl_version = :SSLv3 if @http.respond_to? :ssl_version=
@http.use_ssl = true
@http.verify_mode = OpenSSL::SSL::VERIFY_PEER

@http.start
@http.get '/'
@http.finish

@http.start
@http.get '/'
@http.finish

@http.start
@http.get '/'

socket = @http.instance_variable_get :@socket
ssl_socket = socket.io

assert ssl_socket.session_reused?