class Document
	include Mongoid::Document

	embeds_many :texts
	index "texts.keyline" => 1

	field :name
  # have to run the rake task to build indexes
	index({ name: 1}, {unique: true, name: 'name_index'})

end