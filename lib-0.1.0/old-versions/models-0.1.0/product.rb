class Product
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :details, type: String
  field :price, type: Float
  field :url, type: String
  field :type, type: String
  field :inventory, type: Integer
  field :similar, type: Array
end
