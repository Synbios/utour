class Booking < ActiveRecord::Base
  validates :departure_date, :presence => true
  validates :number_of_people, :presence => true
  validates :tour_id, :presence => true
end
