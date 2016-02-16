class Openport < ActiveRecord::Base
  belongs_to :ip
  belongs_to :service
  belongs_to :network
end
