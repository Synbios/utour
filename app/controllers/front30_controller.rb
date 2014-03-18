class Front30Controller < ApplicationController
  before_action :check_login, only: [:dm]
  before_action :set_sale_channel_id, only: [:group, :free, :quick_booking, :onsale]
  before_action :set_sales, only: [:group, :free, :quick_booking, :onsale]
  layout "front30"

  def home
  	@img1x1s = Image.where("image_type = ?", "首页1x1").shuffle
  	@img2x1s = Image.where("image_type = ?", "首页2x1").shuffle 
  end

  # 企划页
  def landing_page 
  	 @page = "/images/#{params[:page]}"
     @routid = params[:routid]
     @link = params[:link]
  end

  # 出行攻略
  def travel_guide
  end

  def contact_about
  end

  def about
  end

  # 特价专区
  def onsale
    # 过滤过期团队
    @tours = Tour.where("expire_date > ? AND departure_city = ? AND tour_type LIKE '%特价%' ", Time.now, GLOBAL["departure_city"])

    # 过滤无权限浏览的团队
    @tours = @tours.select {|tour| tour.sale_channel_id == @sale_channel_id || SaleChannelMap.where(up_id: tour.sale_channel_id, down_id: @sale_channel_id).count > 0 } if @sale_channel_id.present?
    render 'group'
  end

  # 同业计划
  def dm
  end

  # 视频分享
  def video
  end

  def group
    # 过滤过期团队
    @tours = Tour.where("expire_date > ? AND departure_city = ? AND tour_type LIKE '%跟团游%' ", Time.now, GLOBAL["departure_city"])

    # 过滤无权限浏览的团队
    @tours = @tours.select {|tour| tour.sale_channel_id == @sale_channel_id || SaleChannelMap.where(up_id: tour.sale_channel_id, down_id: @sale_channel_id).count > 0 } if @sale_channel_id.present?

  end

  def free
    # 过滤过期团队
    @tours = Tour.where("expire_date > ? AND departure_city = ? AND tour_type LIKE '%自由行%' ", Time.now, GLOBAL["departure_city"])

    # 过滤无权限浏览的团队
    @tours = @tours.select {|tour| tour.sale_channel_id == @sale_channel_id || SaleChannelMap.where(up_id: tour.sale_channel_id, down_id: @sale_channel_id).count > 0 } if @sale_channel_id.present?
    render 'group'
  end

  # 由行程页面直接进去预订选择时间的快速通道
  def quick_booking
    @tours = [ Tour.find_by_id(params[:tour_id]) ]
    render "group"
  end

  private

  def set_sale_channel_id
    @sale_channel_id = nil
    if current_user.present?
      @sale_channel_id = current_user.sale_channel_id
    elsif SaleChannel.find_by_name("直客渠道").present?
      @sale_channel_id = SaleChannel.find_by_name("直客渠道").id
    end
  end

  def set_sales
    @booking = Booking.new
    if current_user.present?
      @sales = current_user.sales
    else
      @sales = []
    end
  end

end
