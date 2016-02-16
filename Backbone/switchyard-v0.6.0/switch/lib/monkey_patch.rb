class String

	def is_valid_cid?
		return true if self =~ /\w{40}/
		return false
	end

	def is_default?
		return true if self == 'default'
		return false
	end

	def is_valid_gucid?
		return true if self =~ /\w+_\w{40}/
		return false
	end

end
