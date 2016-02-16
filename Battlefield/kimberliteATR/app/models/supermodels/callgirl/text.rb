class Text
	include Mongoid:Document
	include Redis::Objects
	belongs_to :document
	has_many :lines
	embeds

	field :name
	field :body

end