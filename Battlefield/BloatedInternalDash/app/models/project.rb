class Project < ActiveRecord::Base
  belongs_to :infrastructure
  belongs_to :research
  belongs_to :developer
  belongs_to :application
  belongs_to :username
  belongs_to :user
  #belongs_to :member
  belongs_to :organization

  has_many :issuelists
  has_many :tasklists
  has_many :issues
  has_many :tasks
  has_many :bugs
  has_many :todos

  accepts_nested_attributes_for :tasks
  accepts_nested_attributes_for :issues
  accepts_nested_attributes_for :issuelists
  accepts_nested_attributes_for :tasklists, allow_destroy: true
end
