class Departure < ActiveRecord::Base
  has_attached_file :group_notice, :default_url => "missing"

  has_many :prices, :dependent => :destroy
  has_many :bookings, :through => :prices
  belongs_to :tour
  belongs_to :sale_channel
  belongs_to :account

end
