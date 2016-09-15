#!/usr/bin/ruby
# @Author: Samuel Kerr
# @Date:   2016-09-15 01:28:59
# @Last Modified by:   Samuel Kerr
# @Last Modified time: 2016-09-15 01:29:13
 #!/usr/bin/env ruby
  require 'parser'
  require 'storage'
  require 'server'
  require 'yaml' 

  config = YAML.load_file('config.yaml')

  server = RubySyslog::Server.new(config)
  server.start

  while !server.stopped? or server.logs_queued? do
    sleep(1)
    server.process_logs
  end

  server.shutdown