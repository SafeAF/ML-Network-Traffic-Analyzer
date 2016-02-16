class Users < ActiveRecord::Base
  before_filter :authenticate_user!

end