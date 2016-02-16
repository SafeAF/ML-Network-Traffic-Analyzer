class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @dashboard = current_user
  end

  def controls
  end

  def analysis
  end
end
