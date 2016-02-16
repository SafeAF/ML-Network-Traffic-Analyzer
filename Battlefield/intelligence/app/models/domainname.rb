class Domainname < ActiveRecord::Base
  belongs_to :ip
  belongs_to :organisation
  belongs_to :network
  belongs_to :server
end
