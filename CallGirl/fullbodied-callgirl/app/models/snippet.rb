class Snippet
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :name, type: String
  field :description, type: String
  field :code, type: String
  field :authored_at, type: Time
end
