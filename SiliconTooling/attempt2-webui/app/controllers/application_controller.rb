class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.


  include RbacController
#  require 'simple_captcha'
# include SimpleCaptcha::ControllerHelpers

layout 'silicon'

#  skip_before_filter :verify_authenticity_token, :only => [:switchyard]
#  before_filter :semi_verify_authenticity_token, :only => [:switchyard]

# skip_before_filter :authorize

  # before_filter :authenticate, :authorize,
  #               :except => [:home, :products, :pricing, :about, :contact,
  #                           :login, :signup]


  helper :all # include all helpers, all the time

# See ActionController::RequestForgeryProtection for details
# Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery with: :exception
  #protect_from_forgery :except => [:switchyard]

# :secret => '8fc080370e56e929a2d5afca5540a0f7'

# See ActionController::Base for details
# Uncomment this to filter the contents of submitted sensitive data parameters
# from your application log (in this case, all fields with names like "password").
#   filter_parameter_logging :password




  def index

  end

  protected
  def authenticate
    #unless User.find_by_id(session[:user_id])
    unless User.where(id: session[:user_id]).first ## TODO THIS IS NEW METHOD!!
      #rails2:
      #  session[:original_url] = request.request_uri
      session[:original_uri] = request.url
#      flash[:notice] = "Please log in"
      redirect_to :controller => 'profile', :action => 'login'
    end
  end

#	def authorize
#		user = User.find(session[:user_id])
#		unless user.roles.detect{|role|
#		  role.rights.detect{|right|
#		    right.action == action_name &&
#								right.controller == controller_name
#		    }
#		  }
#		  flash[:notice] =
#			"You are not authorized to view the page you requested"
#		  request.env["HTTP_REFERER"] ?
#			(redirect_to :back) : (redirect_to(
#				:controller => 'profile', :action=>'login'))
#
#		return false
#		end
#  	end


#def semi_verify_authenticity_token
#  verify_authenticity_token unless request.post?
#end


end


