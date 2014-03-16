class Departure < ActiveRecord::Base
  has_attached_file :group_notice, :default_url => "missing"

  validates :date, :presence => { :message => "出发时间为必填" }
  validates :expire_date, :presence => { :message => "过期时间为必填" }
  validates :sale_channel_id, :presence => { :message => "渠道为必填" }

  validate :check_number_of_seats

  has_many :prices, :dependent => :destroy
  has_many :bookings, :through => :prices
  belongs_to :tour
  belongs_to :sale_channel
  belongs_to :account

  def confirmed_seats
    total = 0
    self.bookings.each do |booking|
      total += booking.confirmed_seats
    end
    total
  end

  def final_price(klass, sale_channel_id)

    prices = self.prices.where("prices.kind = ?", klass)

    # 除去过期的价格
    prices = prices.select { |price| price.expire_date > Time.now }

    # 除去权限
    prices = prices.select { |price| price.sale_channel_id == sale_channel_id || SaleChannelMap.where(up: price.sale_channel_id, down: sale_channel_id).count > 0 } if sale_channel_id.present?
    
    price = prices.first
    # 找出覆盖后的价格
    if !prices.empty?
      prices.each do |p|
        if SaleChannelMap.where(up: price.sale_channel_id, down: p.sale_channel_id).count > 0
          price = p
        end
      end
    end
    price
  end

  private
    def check_number_of_seats
      errors.add(:number_of_seats, "确认报名人数已多余新设置余位数") if self.number_of_seats.present? && self.confirmed_seats > self.number_of_seats
    end

end


