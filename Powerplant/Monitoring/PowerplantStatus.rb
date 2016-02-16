require 'sidekiq/api'

postque = Sidekiq::Queque.new('postque')
p "Jobs:  #{postque.size}"
p "Latency: #{postque.latency}"
