module Stackish
	class Stack
		def self.all
			@all ||= []
		end
	end
end

class Stickish
	def self.+@
		Stackish::Stack.all << self
	end
end