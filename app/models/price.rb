class Price < ActiveRecord::Base
  has_many :bookings, :dependent => :destroy
	belongs_to :departure
	belongs_to :account
  belongs_to :sale_channel
end
