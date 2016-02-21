class News
  include Mongoid::Document
  field :name, type: String
  field :product, type: ForeignKey
  field :description, type: String
end
