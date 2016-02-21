class Product
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :details, type: String
  field :how, type: String
  field :who, type: String
  field :why, type: String
  field :pricing, type: String
  field :type, type: String
  field :releaseDate, type: Date
end
