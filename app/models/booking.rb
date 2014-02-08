class Booking < ActiveRecord::Base
  validates :date_and_price_id, :presence => true
  validate :check_number_of_booked_people
  
  belongs_to :date_and_price
  belongs_to :account

  private
  	def check_number_of_booked_people
  		errors.add(:number_of_adults, "至少要订一个大人") if number_of_adults + number_of_children == 0
  	end
end
