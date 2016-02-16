class Pubserver < ActiveRecord::Base
  belongs_to :organization
  belongs_to :reputation
  belongs_to :application
  belongs_to :service
  belongs_to :webserver
end
