private

class HandlePost < WEBrick::HTTPServlet::AbstractServlet
	post_err = {}
	post_err[:default] = '::MESSAGE==701 - failure - client has default GUCID'
	post_err[:no_mod] = 'Failure - module not installed: ' +
		'or does not exist'

	def do_POST(request, response)
        WEBrick::HTTPAuth.basic_auth(request, response, "Emergence") {|user, pass|
			#authenticate method is magic imported from kl user model

	      @user_obj = User.authenticate(user, pass)
        }
	 status, content_type, body = process_logs(request)
     response.status = status
     response['Content-Type'] = content_type
     response.body = body
 	end

	def process_logs(request)
	 result = handle_log_submit(request)
     return 200, "text/plain", result.to_s
	end


	def handle_log_submit(request)
		query = request.query
		ret = ''
		# dont post if gucid of default
		return post_err[:default] if query['gucid'].is_default?

		if machine = @user_obj.machines.find_by_cid(query['cid'])

			if instance = machine.instances.find_by_gucid(query['gucid']) 

				return not_subbed_err if instance.subscribed == false

				blood_inputs = []
				pcap = query['pcap_log']
				pcap_inputs = pcap.split("\n")

				result = case query['instance_type']
				when /SSH/i then 

				p post_err[:no_mod] + ' ' + result


				when /APACHE/i then 
					blood_inputs = []
					pcap = query['pcap_log']
					pcap_inputs = pcap.split("\n")

#					process_log(log_inputs
#					process_pcap(pcap_inputs)

					pcap_inputs.each do |packet|
						header, features = packet.split("~~")
						features_str = features.to_s
						pac_time, src_ip, dst_ip, src_port, dst_port = header.split('::')

						blood_output = $apache_mod.run_blood(features_str)
						blood_output = blood_output[0]
						p "NEURAL OUTPUT: #{blood_output}"
##						# do if ml output suggests a ban
						if blood_output > 0.5
							ban = Ban.find_by_ip(src_ip) || Ban.new
							if ban
								ban.reason = blood_output
								ban.last_seen = pac_time
								ban.ip = src_ip
							end
						end	
					end
				end
			else
				return no_subs_found_err('foo')
			end
		else
			return create_a_machine_err
		end
	end
end
