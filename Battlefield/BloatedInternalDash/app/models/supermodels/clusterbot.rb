class Clusterbot
  include Mongoid::Document
  field :name, type: String
  field :hostname, type: String
  field :ip, type: String
  field :cluster_id, type: Integer
  field :uptime, type: Integer
  field :configuration, type: String
end
