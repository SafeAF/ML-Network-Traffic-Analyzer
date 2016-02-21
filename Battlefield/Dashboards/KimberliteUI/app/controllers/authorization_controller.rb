class AuthorizationController < ApplicationController
#private
	roles :Admin
	def index
		controllers = []
		Rails.application.routes.routes.map.each {|route|
			controllers << route.defaults[:controller] unless route.defaults[:controller].nil?
			}
		@controllers = controllers.uniq!.delete_if {|controller|
			is_it_a? controller
			}
		@controllers.collect! {|c| controller_class c}
	end
private
	def controller_class(controller)
		return if controller == "simple_captcha"
		"#{controller.camelize}Controller".constantize
	end
	def is_it_a?(controller)
		the_class = controller_class(controller)
			!the_class.is_a?(Class) ||
			!the_class.ancestors.include?(ApplicationController) ||
			!the_class.included_modules.include?(RbacController)
	end
end
