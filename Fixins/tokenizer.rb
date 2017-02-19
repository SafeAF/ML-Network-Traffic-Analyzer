class Tokenizer
def tokenize(expr, opsTable)
	tokens = expr.split(" ")
	tokens.each do |tok|
		switch tok

		word = tok =~ /\A\w+\Z/ ? :tok : nil
		number = tok =~/\Ad+\Z/
		#opsTable[type || tok][tok]
		end

	end
end
end
