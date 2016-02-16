class Organization < ActiveRecord::Base
  include Mongoid::Document
  field :name, type: String
  field :address, type: String
  field :phone, type: String
  field :employees, type: Integer
  field :details, type: String
  field :description, type: String
  field :criticality, type: Integer

  has_one :infrastructure
  has_many :clusters
  has_many :operations
  has_many :networks
  has_many :users
  has_many :machines
  has_many :servers

end
