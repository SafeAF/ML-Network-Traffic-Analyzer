class ApplicationController < ActionController::Base
  attr_accessor :navicons

  ## Configuration ##

  #config.web_console.whitelisted_ips = '10.0.1.42'
  #config.web_console.whitelisted_ips = '10.0.1.0/16'

  ## Notes ##
  # helper_method :foo for static things throughout app, nav
  # before_filter for things that change from controller to controler

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
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
