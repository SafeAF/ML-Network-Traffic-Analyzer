class Reputation < ActiveRecord::Base
  belongs_to :ip
  belongs_to :domain
end
