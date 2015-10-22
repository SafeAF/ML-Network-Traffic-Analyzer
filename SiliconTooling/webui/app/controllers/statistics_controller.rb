class StatisticsController < ApplicationController
  def index

    @user = User.find(session[:user_id])
    @machine = @user.machines.find(params[:machine_id])
    @statistics = @machine.statistics

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @machines }
    end
  end


end
