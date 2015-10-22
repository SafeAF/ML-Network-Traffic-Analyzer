module Switching::MD5Auth
  def auth
    app = Rack::Auth::Digest::MD5.new(super)  do |user, pass|
      @usar = User.authenticate(user, pass)

    end
    app.realm = 'Emergence'
    app.opaque = 'greatbigphoobarnkey'
  end
end


module Switching::BasicAuth
  def auth

  end
end