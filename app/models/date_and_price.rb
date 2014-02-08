class DateAndPrice < ActiveRecord::Base
	belongs_to :tour
	has_many :bookings
end
