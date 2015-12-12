require 'yahoo-finance'
# OG HEAVENLY HORDE FOR LIFE ESSE
class Quote
  attr_accessor :last, :ask, :bid, :average_daily_volume, :book_value, :change, :change_in_percent, :symbol
end

class Quotes
  attr_accessor :ticker, :symbols, :yapi, :current, :allHistoryData, :quoteData, :rangeData

  def initialize()
    @yapi = YahooFinance::Client.new
  end

  def get_symbols(country='us', market='nyse')
    @symbols = @yapi.symbols_by_market(country, market) # only does us stock markets
  end

  def get_quotes()
    @quoteData = @yapi.quotes(self.symbols)
  end

#startDate: Time::now-(24*60*60*10), endDate: Time::now
  def get_range_historical_quotes(sym,startDate, endDate)
    @rangeData = @yapi.historical_quotes(sym, { start_date: startDate, end_date: endDate})
  end

  def get_historical_quote(sym)
    @allHistoryData = @yapi.historical_quotes(sym)

  end
end

require 'mongo'
require 'mongoid'
q = Quotes.new
p q.get_quotes(['rio'])


#q.get_symbols
#p q.get_quotes
#p q.quoteData


  __END__

          :after_hours_change_real_time
     :annualized_gain
     :ask
     :ask_real_time
     :ask_size
     :average_daily_volume
     :bid
     :bid_real_time
     :bid_size
     :book_value
     :change
     :change_and_percent_change
     :change_from_200_day_moving_average
     :change_from_50_day_moving_average
     :change_from_52_week_high
     :change_From_52_week_low
     :change_in_percent
     :change_percent_realtime
     :change_real_time
     :close
     :comission
     :day_value_change
     :day_value_change_realtime
     :days_range
     :days_range_realtime
     :dividend_pay_date
     :dividend_per_share
     :dividend_yield
     :earnings_per_share
     :ebitda
     :eps_estimate_current_year
     :eps_estimate_next_quarter
     :eps_estimate_next_year
     :error_indicator
     :ex_dividend_date
     :float_shares
     :high
     :high_52_weeks
     :high_limit
     :holdings_gain
     :holdings_gain_percent
     :holdings_gain_percent_realtime
     :holdings_gain_realtime
     :holdings_value
     :holdings_value_realtime
     :last_trade_date
     :last_trade_price
     :last_trade_realtime_withtime
     :last_trade_size
     :last_trade_time
     :last_trade_with_time
     :low
     :low_52_weeks
     :low_limit
     :market_cap_realtime
     :market_capitalization
     :more_info
     :moving_average_200_day
     :moving_average_50_day
     :name
     :notes
     :one_year_target_price
     :open
     :order_book
     :pe_ratio
     :pe_ratio_realtime
     :peg_ratio
     :percent_change_from_200_day_moving_average
     :percent_change_from_50_day_moving_average
     :percent_change_from_52_week_high
     :percent_change_from_52_week_low
     :previous_close
     :price_eps_estimate_current_year
     :price_eps_Estimate_next_year
     :price_paid
     :price_per_book
     :price_per_sales
     :shares_owned
     :short_ratio
     :stock_exchange
     :symbol
     :ticker_trend
     :trade_date
     :trade_links
     :volume
     :weeks_range_52