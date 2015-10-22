class AboutController < ApplicationController
skip_before_filter :authenticate, :authorize

# use before_filter to get @user - make priv func
  # GET /machines
  # GET /machines.xml
  def index


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @machines }
    end
  end



end
