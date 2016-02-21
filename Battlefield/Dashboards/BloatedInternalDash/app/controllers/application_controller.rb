class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # for global search
  before_action :global_search_form


  layout 'admin_lte_2'



  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :error, :info
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_error

  private

  def global_search_form
    if params[:globalsearch].present?
      @search = System.near(params[:globalsearch], 100).search(params[:q])
    else
      @search = System.search(params[:id])
    end
  end

  def go_back_link_to(path)
    @go_back_link_to ||= path
    @go_back_link_to
  end

  def render_404
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def render_error
    render file: 'public/500.html', status: :internal_server_error, layout: false
  end
  def logged_in?
    current_user
  end
  helper_method :logged_in?

  # def current_user
  #   if session[:user_id]
  #     @current_user ||= User.find(session[:user_id])
  #   elsif cookies.permanent.signed[:remember_me_token]
  #     verification = Rails.application.message_verifier(:remember_me).verify(cookies.permanent.signed[:remember_me_token])
  #     if verification
  #       Rails.logger.info "Logging in by cookie."
  #       @current_user ||= User.find(verification)
  #     end
  #   end
  # end
 # helper_method :current_user

  def require_user
    if current_user
      true
    else
      redirect_to new_user_session_path, notice: "You must be logged in to access that page."
    end
  end

   attr_accessor :navicons

    ## Configuration ##

    #config.web_console.whitelisted_ips = '10.0.1.42'
    #config.web_console.whitelisted_ips = '10.0.1.0/16'

    ## Notes ##
    # helper_method :foo for static things throughout app, nav
    # before_filter for things that change from controller to controler

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.

    before_filter :populate_navicons
    before_filter :populate_names

    ## :noti if for first icon the notification system
    def populate_navicons
      @navicons = Hash.new
      @navi = []

      @navicons[:first] = 5

      @navicons[:noti] = Array.new
      ## TODO Replace this with notification model
      @navicons[:noti] << ["BMN Ops Team", "Thank you for signing up!", '10 mins']

      @navicons[:second] = 18
      @navicons[:third] = 2
    end


    def populate_names
      @appTitle = "CallGirl"
      @topLevelName = "Titan SuperCluster" ## REPLACE # with infrastructure.name
      @centralLogRepo = "Manager0.local.bmn.com"
      @stack0 = "stack0.local.bmn.com"
    end

    #@navicons[:first] = {value: 0, msg: "You have #{@navicons[:first][:value]} notifications pending"}


end
