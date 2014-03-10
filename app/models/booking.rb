class Booking < ActiveRecord::Base
  validates :price_id, :presence => true
  validate :check_number_of_booked_people
  validate :check_confirmed_seats
  
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

    def check_confirmed_seats
      total = self.price.departure.confirmed_seats
      errors.add(:confirmed_seats, "报名超额: 总共#{self.price.departure.number_of_seats}, 已确认#{total}") if self.confirmed_seats + total > self.price.departure.number_of_seats
      errors.add(:confirmed_seats, "报名人数不能为负数") if self.confirmed_seats < 0 
    end
end
