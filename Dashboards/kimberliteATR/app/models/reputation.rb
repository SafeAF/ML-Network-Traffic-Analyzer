class Reputation
  include Mongoid::Document
  field :confidence, type: Float
  field :description, type: String
  field :value, type: Integer
  embedded_in :ip
  embedded_in :domain
end
