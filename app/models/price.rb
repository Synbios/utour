class Price < ActiveRecord::Base
  has_many :bookings, :dependent => :destroy
  belongs_to :departure
  belongs_to :account
  belongs_to :sale_channel

  validates :expire_date, :presence => { :message => "过期时间为必填" }
  validates :sale_channel_id, :presence => { :message => "渠道为必填" }

  def confirmed_seats
    total = 0
    self.bookings.each do |booking|
      total += booking.confirmed_seats
    end
    total
  end


end
