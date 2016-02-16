module RbacController
#private
	def self.included(base)
		base.extend(AuthorizationClassMethods)
	end
	def authorize
		user = User.find(:first,
			:conditions => ["id = ?" , session[:user_id]])
		users_roles = []
		user.roles.each {|role| users_roles << role.name.to_sym }
		readable_roles = users_roles.join(", ")
		action_name = request.parameters[:action].to_sym
		action_roles = self.class.access_list[action_name] unless self.class.access_list.nil?
		logger.info "[AUTH] #{self.class}, #{action_roles}"
		if action_roles.nil?
			logger.error "[AUTH] You must provide a roles declaration " +
				"or add skip_before_filter :authorize to " +
				"the beginning of #{self}."
			# We deliberately did not return any information to the user here.
			# This is considered a programmer error. We could also raise an
			# Error or Exception here. If we wanted to switch to a blacklist
			# version of the role based access control, this would allow the
			# Action. However, this violates two of our principles; Least
			# Privilege, Whitelist
			redirect_to :controller => 'home' , :action => 'index'
			return false
		# Make sure user and action share a role
		elsif action_roles & users_roles != []
			logger.info "[AUTH] #{user.name} (role: #{readable_roles}) was granted access" +
						" to #{self.class}##{action_name}."
			return true
		else
			logger.info "[AUTH] #{user.name} (role: #{readable_roles}) attempted to access " +
					"#{self.class}##{action_name} without the proper permissions."
			flash[:notice] = "Not authorized!"
			redirect_to :controller => 'home' , :action => 'index'
			return false
		end
	end
end

module AuthorizationClassMethods
	def self.extended(base)
		class << base
			def access_list
				@access_list ||= {}
			end
		end
	end
	def roles(*roles)
		@roles = roles
	end
	def method_added(method)
		logger.debug "#{caller[0].inspect}"
		logger.debug "#{method.inspect}"
		access_list[method] = @roles unless @roles.nil?
	end
end
