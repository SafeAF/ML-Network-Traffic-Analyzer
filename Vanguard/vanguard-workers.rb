require 'sidekiq'


class TitanStatusSpy
  include Sidekiq::Worker

  def perform(ip, service='ssh')
    #foo = []
    #foo.each { |x| }

    ret = check_server_availability(ip, service)
    $SHM[ip] = ret

  end

  end