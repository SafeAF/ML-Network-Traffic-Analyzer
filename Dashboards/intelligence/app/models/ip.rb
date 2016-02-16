class Ip < ActiveRecord::Base
  belongs_to :network
  belongs_to :domainname
  belongs_to :organization
  belongs_to :credibility
end
