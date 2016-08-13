#!/usr/bin/env ruby
require 'redis-objects'
require 'mongoid'
require 'sidekiq'
require 'mongo'
require 'connection_pool'

redis_conn = proc {
  Redis.current = Redis.new(:host => '10.0.1.75', :port => 6379, :db => 5)
}
Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 15, &redis_conn)
end
Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
  config.on(:startup) do
    # make_some_singleton
  end
  config.on(:quiet) do
    puts "Got USR1, stopping further job processing..."
  end
  config.on(:shutdown) do
    puts "Got TERM, shutting down process..."
    # stop_the_world
  end


  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=#{$SERVER_CONCURRENCY}"
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

    Mongoid.load!('mongoid.yml', :development)

    # Note that as of Rails 4.1 the `establish_connection` method requires
    # the database_url be passed in as an argument. Like this:
    # ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  end

  config.redis = ConnectionPool.new(size: 27, &redis_conn) # must be concur+2
end

Sidekiq.default_worker_options = { 'backtrace' => true , :dead => false}
$PSHM = Redis::List.new('yard:connector')


# gem install RubyInline
#require 'rubygems'
require 'inline'

module Preprocessor
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
    stats.to_json

  end
end



class LogPreprocessor
	include Sidekiq::Worker
	include Redis::Objects

end


class RedisExcersizerWorker
  include Sidekiq::Worker
  include Redis::Objects

  redis_id_field :jid
  counter :jobcount
  value :latency
  def perform(how_hard="super hard", how_long=1)
		magnet:?xt=urn:btih:c9cd77928465e193fb20bc812b59ac1ab8c23bf1&dn=The.Iceman.2012.BRRip+XViD+juggs&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969&tr=udp%3A%2F%2Fzer0day.ch%3A1337&tr=udp%3A%2F%2Fopen.demonii.com%3A1337&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Fexodus.desync.com%3A6969
    puts "Workin' #{how_hard}"

    redinfo = ""
    Sidekiq.redis {|conn| conn.info}
    $PSHM.push "test foo bar #{rand(1..10)} ::: #{redinfo}"
  end

  def bulk
    Sidekiq::Client.push_bulk('class' => HardWorker,
                              'args' => [['bob', 1, 1], ['mike', 1, 2]])
  end
end