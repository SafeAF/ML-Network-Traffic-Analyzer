class StatisticsController < ApplicationController
  def index


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @machines }
    end
  end


end
