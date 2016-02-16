## ERRORS ##

 def no_subs_found_err(gucid)
	r = ''
	if gucid
		unless gucid.include? 'default'
			r += '::DELETE==' + gucid 
		end
	end
 
	r += '::SERVER_VERSION==' + $VERSION +
	'::MESSAGE==610-'+ gucid + '-No subscriptions found' +
	' or invalid gucid' +
	' please subscribe to have a' +
	' service monitored ++ Find us @' +
	'http://bmnlabs.com'
 end

 def invalid_cid_err(cid)
	r = '::MESSAGE==626~~Invalid machine identification number'
 end

  def invalid_gucid_err(gucid)
	r = '::DELETE==' + gucid +
	'::MESSAGE==625~~An exception has been ' +
	'encountered: you are running a non-standard client, ' +
	'please install a standard client from ' +
	'BareMetal Networks ++ Find us at ' +
	'http://bmnlabs.com'
  end

	def create_a_machine_err
	 r = "::MESSAGE==611~~Please create a machine @ bmnlabs.com"
	end

	def not_subbed_err
	 r = "::MESSAGE==612~Instance installed but not subscribed, get a subscription to activate this instance"
	end
