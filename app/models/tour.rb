class Tour < ActiveRecord::Base
	has_many :date_and_prices
	has_many :days, :dependent => :destroy
	has_many :activities, through: :days

	accepts_nested_attributes_for :days, :reject_if => lambda { |a| a[:number].blank? }, :allow_destroy => true

	belongs_to :account

	def generate_itinerary(force=false)
		self.days.each do |day|
			day.generate_itinerary(force)
		end
	end

	def lowest_readable_price(account=nil)
		prices = readable_date_and_prices(account)
		if prices.nil?
			return nil
		else
			lowest_trade = prices.first.trade_price
			lowest_retail = prices.first.retail_price
			prices.each do |price|
				lowest_retail = price.retail_price if price.retail_price < lowest_retail
				lowest_trade = price.trade_price if price.trade_price < lowest_trade
			end
			return { trade: lowest_trade, retail: lowest_retail }
		end
	end

	def readable_date_and_prices(account=nil)
		self.date_and_prices
	end
end
