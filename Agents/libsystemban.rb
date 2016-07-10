module AttritionAPI
attr_accessor :options, :action, :instance
def http_get(instance, options, action)
  return if instance.nil?
  begin

    uri = URI.parse('https://' + options[:host] +
                        ':' + options[:port] + "/#{action}/")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl= true
    http.start() do |http|
      req = Net::HTTP::Get.new(
          "/#{action}?gucid=" + instance.gucid +
              '?cid=' + options[:cid])
      req.basic_auth options[:user], options[:pass]
      response = http.request(req)
      response.body
    end

  rescue Exception
    sleep options[:retry]
    #options[:host] = rotate_hosts('sw', options[:host],
    #                              options[:serv_rotate_min], options[:serv_rotate_max])
    retry
  end
end
end

def parse_deny_file(options)
  hosts_denied = []
  if FileTest.exists? options[:deny_file]
    deny_hosts = File.open(options[:deny_file], 'r')
    if deny_hosts.nil?
      @elogger.fatal(get_time + "(FATAL)" +
                         "Error opening hosts.deny file: #{$!}" )
      raise "Error opening hosts.deny file: #{$!}"
    elsif deny_hosts.respond_to?("each")
      deny_hosts.each do |denied|
        next if /^#/ =~ denied
        #if /^ALL:\s+(.*)\s*$/ =~ denied
        # add banlist duration handling
        #m/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\$/;

        if /^\w+:\s+(.*)\s*$/ =~ denied
          $1.chomp!
          hosts_denied.push $1
        end
      end
    end
  else
    ### FUTURE: use iptables if file doesnt exist
    raise "Error: deny file does not exist."
  end
  deny_hosts.close
  hosts_denied
end


# add lamda to switch append and write for add_to and remove_from deny
def add_to_deny_file(hoststodeny, location)
  if hoststodeny.nil?
    raise "No array of hosts given"
  elsif hoststodeny.respond_to?("each")
    deny_file = File.open(location, 'a+')
    if deny_file
      hoststodeny.each do |host|
        next if host.nil?
        host.chomp!
        next if host !~ /^\d+\.\d+\.\d+\.\d+$/
        deny_file.puts "ALL: " + host
      end
      deny_file.close
    else
      @elogger.fatal(get_time + "(FATAL)" +
                         "Error opening hosts.deny file: #{$!}")
      raise "Error opening hosts.deny file: #{$!}"
    end
  end
end

def ban(to_ban_dirty, options)
#	needs error checking
  return if to_ban_dirty.nil?
  to_ban = clean(to_ban_dirty)

  #fix
  already_banned = parse_deny_file options
  already_banned.collect { |x| x.chomp! }
  already_banned.uniq!

  bans_to_write = to_ban - already_banned
  bans_to_write.uniq!
  add_to_deny_file(bans_to_write, options[:deny_file])

#@logger.info(get_time + to_ban.to_s)
end

