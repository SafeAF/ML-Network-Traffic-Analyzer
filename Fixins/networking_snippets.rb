require 'openssl' rescue nil
require 'resolv'
require 'thread'
require 'socket'
HOSTNAME = Socket.gethostbyname(Socket.gethostname).first rescue Socket.gethostname