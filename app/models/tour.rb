class Tour < ActiveRecord::Base
	has_many :date_and_prices
	belongs_to :account
end
