class Departure < ActiveRecord::Base
	has_many :prices, :dependent => :destroy
	belongs_to :tour
	belongs_to :sale_channel
	belongs_to :account
end
