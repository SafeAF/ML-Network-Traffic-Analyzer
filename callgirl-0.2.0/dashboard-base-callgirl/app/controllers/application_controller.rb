class ApplicationController < ActionController::Base
  attr_accessor :navicons
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


  end

  #@navicons[:first] = {value: 0, msg: "You have #{@navicons[:first][:value]} notifications pending"}


end
