class Tour < ActiveRecord::Base

	has_many :days, :dependent => :destroy
	has_many :activities, through: :days
	has_many :departures, :dependent => :destroy
	has_many :prices, :through => :departures
	has_many :bookings, :through => :prices
	belongs_to :account
	belongs_to :sale_channel
	belongs_to :cover_img, :class_name => 'Image', :foreign_key => :cover_img_id
	belongs_to :icon_img, :class_name => 'Image', :foreign_key => :icon_img_id

	accepts_nested_attributes_for :days, :reject_if => lambda { |a| a[:number].blank? }, :allow_destroy => true

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

	def generate_title
		self.days.each do |day|
			day.generate_title
		end
	end

	def readable_date_and_prices(account=nil)
		self.date_and_prices
	end
end
