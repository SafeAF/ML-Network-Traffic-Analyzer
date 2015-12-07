private

class CheckUpdate < WEBrick::HTTPServlet::AbstractServlet
	def do_GET(request, response)
		WEBrick::HTTPAuth.basic_auth(request, response,
																 "Emergence") {|user, pass|
			# this block returns true if
			# authentication token is valid
			#authenticate method is magic imported from kl user model
			@user_obj = User.authenticate(user, pass)
		}

		status, content_type, body = check_update_flag(request)
		response.status = status
		response['Content-Type'] = content_type
		response.body = body
	end

	def check_update_flag(request)
		gucid, cid_bug = request.query['gucid'].split("?")
		bug, cid = cid_bug.split("=")
		update_flag = 0

		unless gucid.include? 'default'
			machine = @user_obj.machines.find_by_cid(cid)

			if machine
				instance = machine.instances.find_by_gucid(gucid)
				if instance.conf.update_flag == 1
					update_flag = 1
					machine.just_seen(request.peeraddr[3])
					# FIXME: this is a hack
					instance.conf.update_flag = 0
				end
			else


			end
			response = update_flag
		end

		return 200, "text/plain", response.to_s
	end
end

class GetBans < WEBrick::HTTPServlet::AbstractServlet
	def do_GET(request, response)
		WEBrick::HTTPAuth.basic_auth(request, response,
																 "Emergence") {|user, pass|
			# this block returns true if
			# authentication token is valid
			#authenticate method is magic imported from kl user model
			@user_obj = User.authenticate(user, pass)
		}

		status, content_type, body = get_bans()
		response.status = status
		response['Content-Type'] = content_type
		response.body = body
	end

	# figure out how we are gonna send bans back to the user
	# all the bans from today? how to avoid redundancy while not
	# missing any new bans
	def get_bans
		bans = Ban.find(:all, :conditions =>
														["last_seen > ?", (Time.now - (60 * 60 * 24)).to_s])


	end


end



class HandleGet < WEBrick::HTTPServlet::AbstractServlet
	@user_obj = nil

	def do_GET(request, response)

		WEBrick::HTTPAuth.basic_auth(request, response,
																 "Emergence") {|user, pass|
			@user_obj = User.authenticate(user, pass)

		}

		status, content_type, body = generate_response(request)
		response.status = status
		response['Content-Type'] = content_type
		response.body = body
	end

	def generate_response(request)
		response = process_instance_req(request)
#		response = create_client_config_parcel(request)
		return 200, "text/plain", response
	end


	def process_instance_req(request)
		gucid, cid_bug = request.query['gucid'].split("?")
		bug, cid = cid_bug.split("=")
		cid = cid.to_s
		gucid = gucid.to_s
		#	return invalid_cid_err unless cid.is_valid_cid?

		# machine found
		if machine = @user_obj.machines.find_by_cid(cid)
			machine.just_seen(request.peeraddr[3])

			if gucid.is_default?

				if instance = machine.sub_instance_avail?
					instance.just_seen(request.peeraddr[3])
					return instance.serialize_conf

				else
					return no_subs_found_err(gucid)
				end

			elsif gucid.is_valid_gucid?

				if instance = machine.instances.find_by_gucid(gucid)
					return not_subbed_err if instance.subscribed == false
					instance.just_seen(request.peeraddr[3])
					return instance.serialize_conf
				end

			else
				return invalid_gucid_err(gucid)
			end

			#no machine found
		else
			if machine = @user_obj.machine_avail?
				machine.cid = cid
				machine.just_seen(request.peeraddr[3])

				if instance = machine.sub_instance_avail?
					instance.just_seen
					return instance.serialize_conf
				else
					return no_subs_found_err(gucid)
				end
			else
				return create_a_machine_err
			end


		end
	end

end
