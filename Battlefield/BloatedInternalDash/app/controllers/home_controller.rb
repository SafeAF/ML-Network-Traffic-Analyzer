class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  def slice
  end
end
