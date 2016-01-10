require 'yahoo-finance'
require 'hiredis'
require 'redis'
require 'redis-objects'
require 'connection_pool'

# OG HEAVENLY HORDE FOR LIFE ESSE
module Stock
  class Quote
    attr_accessor :last, :ask, :bid, :average_daily_volume, :book_value, :change, :change_in_percent, :symbol
  end

  class Quotes
    attr_accessor :ticker, :symbols, :yapi, :current, :allHistoryData, :quoteData, :rangeData

    def initialize()
      @yapi = YahooFinance::Client.new
    end

    def get_symbols_nyse(country='us', market='nyse')
      @symbols = @yapi.symbols_by_market(country, market) # only does us stock markets
    end

    def get_quotes(symbols, market='nyse')
      @quoteData = @yapi.quotes(symbols) #if :market.match /nyse/
    end

#startDate: Time::now-(24*60*60*10), endDate: Time::now
    def get_range_historical_quotes_nyse(sym,startDate, endDate)
      @rangeData = @yapi.historical_quotes(sym, { start_date: startDate, end_date: endDate})
    end

    def get_historical_quote(sym)
      @allHistoryData = @yapi.historical_quotes(sym)

    end
  end
end

# q = Quotes.new
# p q.get_quotes(['rio'])
#
# Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) { Redis.new({host: 'stack0', db: 15})}
# $SHM = Redis::List.new('stock:quotes')
#q.get_symbols
#p q.get_quotes
#p q.quoteData

__END__