class Source
  include Mongoid::Document
  field :name, type: String
  field :body, type: String
  field :description, type: String
  field :user_id, type: Integer
  field :developer_id, type: Integer
end
