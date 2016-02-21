class Metrics
	include Redis::Objects

	counter :hits
	value :latency
end