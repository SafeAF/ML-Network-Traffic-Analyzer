class StatusController < ApplicationController
  def index
    @uptime = `uptime`
    @clusterHealth = 100.0
    @nodes = []
    @nodeCount = @nodes.length
    @localIp = get_ip()
    @localNet = get_net()
    @localListeners = get_listeners()
    @localListenersCount = get_listeners_count()
    @localDisk = get_disk()
    @localMem = get_mem()
    @localLoad = get_load()
  end

  def detail
  end



  private
  def get_ip
    UDPSocket.open {|s| s.connect("64.233.187.99",1); s.addr.last}
  end

  def get_hostname
    `hostname`
  end

  def get_listeners_count
    `netstat -tanp | grep -i LISTEN | wc -l`
  end

  def get_listeners
    `netstat -tanp | grep -i LISTEN`
  end
  def get_net
#	`netstat -tanp | sed -n '1!p' | awk {'print $1 $2 $3 $4 $5 $5 $6'}`
    ` netstat -tanp`
  end
  def get_disk
    f = `df -h | sed -n '1!p' |awk {'print $1 $2 $3 $4'}`
    disk = Hash.new
    disk[:fs], disk[:size], disk[:used], disk[:avail] = f.chomp.split(" ")
    disk
  end


  def get_mem
    mem = Hash.new                             13
    sysMem =  `free -m | tail -n 3 | head -1| awk {'print $2,$3,$4,$5,$6,$7'}`
    mem[:total], mem[:used], mem[:free], mem[:shared], mem[:buffers],
        mem[:cached]  = sysMem.chomp.split(" ")

    sysBuff = `free -m | tail -n 2 | head -1 | awk {'print $3,$4,$5,$6,$7'}`
    mem[:pmbuff], mem[:pmcache] = sysBuff.chomp.split(" ")
    mem      # include swappy at some point probably
  end

  def get_load
    #@load1, @load5, @load15 = `uptime | awk {'print $10 $11 $12'}`.chomp.split(',')
    `uptime | awk {'print $8 $9 $10 '}`.chomp.split(',')
  end

end
