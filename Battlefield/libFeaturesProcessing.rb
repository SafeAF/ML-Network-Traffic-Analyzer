#require 'rubygems'
require 'RubyInline'

class Libem
	inline :C do |builder|
		builder.c %q{
			static VALUE calc_unigrams(VALUE payload) {
				VALUE unigram_hash = rb_hash_new();
				char *data = STR2CSTR(payload);
				int i;
				char unigram[2];
				VALUE count;
				for (i = 0; i <= strlen(data) - 1; i++) {
					snprintf(unigram, sizeof(unigram), "%1c", data[i]);
					if (NIL_P(rb_hash_aref(unigram_hash, 
							rb_str_new2(unigram))))
						count = INT2NUM(1);
					else {
						count = rb_hash_aref(unigram_hash, 
							rb_str_new2(unigram));
						count = INT2NUM(NUM2INT(count) + 1);
						}
					rb_hash_aset(unigram_hash, 
						rb_str_new2(unigram), count);
					}
				return unigram_hash;
				}
			}
	end
	inline :C do |builder|
		builder.c %q{
			static VALUE calc_bigrams(VALUE payload) {
				VALUE bigram_hash = rb_hash_new();
				char bigram[3];
				char *data = STR2CSTR(payload);
				int i, count;
				for (i = 0; i <= strlen(data) - 1; i++) {
					if (i <= (strlen(data) - 2)) {
						snprintf(bigram, sizeof(bigram), "%1c%1c", 
								data[i], data[i+1]);
						if (NIL_P(rb_hash_aref(bigram_hash, 
								rb_str_new2(bigram))))
							count = INT2NUM(1);
						else {
							count = rb_hash_aref(bigram_hash, 
								rb_str_new2(bigram));
							count = INT2NUM(NUM2INT(count) + 1);
							}
						rb_hash_aset(bigram_hash, 
							rb_str_new2(bigram), count);
						}
					}
				return bigram_hash;
				}
			}
	end
	inline :C do |builder|
		builder.c %q{
			static VALUE calc_stats(VALUE payload) {
				char *data  = STR2CSTR(payload);
				VALUE stats_hash = rb_hash_new();
				int i, total_chars = 0, count_zero = 0;
				int count_visible = 0;
				int count_nonvisible = 0;
				int count_bigrams = 0;
				double prop_visible = 0;
				double prop_nonvisible = 0;
				double prop_zero = 0;
				for (i = 0; i <= strlen(data) - 1; i++) {
					
					total_chars++;
					if (data[i] >=32 && data[i] <= 128)
						count_visible++;
					else if (data[i] < 32 || data[i] > 128)
						count_nonvisible++;
					if (data[i] == 48) count_zero++;
					}
				prop_visible = (double) count_visible / total_chars;
				prop_nonvisible = (double) count_nonvisible /
					total_chars;
				prop_zero = (double) count_zero / total_chars;
				rb_hash_aset(stats_hash, rb_str_new2("total_chars"),
					INT2NUM(total_chars));
				rb_hash_aset(stats_hash, rb_str_new2("count_visible"),
					INT2NUM(count_visible));
				rb_hash_aset(stats_hash, rb_str_new2("count_nonvisible"),
					INT2NUM(count_nonvisible));
				rb_hash_aset(stats_hash, rb_str_new2("count_zero"),
					INT2NUM(count_zero));
				rb_hash_aset(stats_hash, rb_str_new2("prop_visible"),
					rb_float_new(prop_visible));
				rb_hash_aset(stats_hash, rb_str_new2("prop_nonvisible"),
					rb_float_new(prop_nonvisible));
				rb_hash_aset(stats_hash, rb_str_new2("prop_zero"),
					rb_float_new(prop_zero));
				return stats_hash;
				}
			}
	end

	def prepare_features(payload)
		features = ""
		ug = []
		bg = []
		stat = []
		ugs = self.calc_unigrams(payload)
		bgs = self.calc_bigrams(payload)
		stats = self.calc_stats(payload)
		stats["count_unigrams"] = ugs.keys.count
		stats["count_bigrams"] = bgs.keys.count
		stats["mf_unigram"] = ugs.max_by {|key, value| value}
		stats["prop_mf_unigram"] = ugs.values.max.quo(stats["count_unigrams"]).to_f
		stats["mf_bigram"] = bgs.max_by {|key, value| value}
		stats["prop_mf_bigram"] = bgs.values.max.quo(stats["count_bigrams"]).to_f
		
		stats.sort.each {|key,value|
			features += value.to_s + ','
			}
		features.chomp! ","
		features
	end
end


