# inject the http connection? as http-persistent?
def submit_logfile(url, gucid=nil, logfile=nil, pcapfile=nil)

  begin
    @uri = URI.parse(url)

    @http = Net::HTTP.new(@uri.host, @uri.port)
    @req = Net::HTTP::Post.new(@uri.path)
    #	@http.use_ssl = true
    @req.basic_auth $options[:user], $options[:pass]
    @req.set_form_data({
                           'user' => 'attritiondemo',
                           'pass' => 'afoobasspassword',#
                           #				'instances_installed' => @instances.keys.join('--'),
                           'platform' => RUBY_PLATFORM,
                           'instance_type' => self.instance_type,
                           'hostname' => self.hostname,
                           'client_version' => $options[:version],
                           'gucid' => gucid,
                           'cid' => $options[:cid],

                           'log' => logfile,
                          # 'pcap_log' => pcapfile,
                       } )
    @response = @http.request(@req)
    return @response.body

  rescue Exception => err
    print "[#{Time.now}] Error: Exception #{err.inspect}"
    puts "[#{Time.now}] Error: Backtrace #{err.backtrace}"
    sleep 5
    retry
  end
end

log = StringIO.new
log << 'rtesteskj \n'
log << 'kajelkajrla lakrjalkjrfkla lakjfelkajfklajwwwwwww\n'

submit_logfile('http://10.0.1.8:4567/logs', )