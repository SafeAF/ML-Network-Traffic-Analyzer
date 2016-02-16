class Ip < ActiveRecord::Base
  has_many :domainnames
  # include Mongoid::Document
  # field :address, type: String
  # field :hostname, type: Integer
  # field :dns, type: String
  # field :isp, type: String
  # field :netblock, type: String
  # field :subnet, type: String
  # field :reputation, type: Integer
  # embedded_in :network
  # embedded_in :dns
  # embedded_in :organization
end
