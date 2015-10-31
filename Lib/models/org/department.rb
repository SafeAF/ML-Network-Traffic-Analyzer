class Department
  include Mongoid::Document
  field :string, type: Name
  field :string, type: Description
  field :integer, type: OrganizationId
  field :text, type: Details
end
