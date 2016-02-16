require 'net/http/persistent'
require 'json'
uri = URI.parse("http://10.0.1.8:5000/alarm")

# Shortcut
begin
response = Net::HTTP.post_form(uri, {"header" => "My query", "body" => "50"})
p response.body

rescue
  sleep 1
  retry
end

__END__
require 'net/http/persistent'

uri = URI.parse("http://example.com/search")

# Shortcut
response = Net::HTTP.post_form(uri, {"q" => "My query", "per_page" => "50"})

# Full control
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Post.new(uri.request_uri)
request.set_form_data({"q" => "My query", "per_page" => "50"})

response = http.request(request)

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