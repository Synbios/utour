class Booking < ActiveRecord::Base
  validates :price_id, :presence => true
  validate :check_number_of_booked_people
  
  belongs_to :date_and_price
  belongs_to :price 

  belongs_to :agent, :class_name => 'Account', :foreign_key => 'agent_id'
  belongs_to :sale, :class_name => 'Account', :foreign_key => 'sale_id'
#  has_many :departures, :through => :price 
#  has_many :tours, :through => :departure

  private
  	def check_number_of_booked_people
  		errors.add(:number_of_adults, "至少要订一个大人") if number_of_adults + number_of_children == 0
  	end
end
