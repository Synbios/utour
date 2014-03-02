class Admin::PlateformsController < ApplicationController
  before_action :check_login

  layout false

  def dashboard
    @account = current_user

  end

  def home

  end

  def inbox

  end

  def email_list

  end

  def email_compose

  end

  def calendar

  end

  def invitation_code_control
    if current_user.user_class_id == 1 #
      @user_classes = UserClass.all
    elsif current_user.user_class_id == 2
      @user_classes = [ UserClass.find_by_id(2), UserClass.find_by_id(3), UserClass.find_by_id(4), UserClass.find_by_id(5) ]
    elsif current_user.user_class_id == 3
      @user_classes = [ UserClass.find_by_id(3) ]
    elsif current_user.user_class_id == 4
      @user_classes = [ UserClass.find_by_id(5) ]
    end

    @user_groups = UserGroupMap.desc_sale_channels(current_user.user_group_id)
    @sale_channels = SaleChannelMap.desc_sale_channels(current_user.sale_channel_id)
  end

  def account_control
    @user_groups = UserGroup.all
  end

  def staff_index
    #@staff = Account.where("user_class_id <= 4")
  end

  def agent_index
    #@agents = Account.where("user_class_id = 5")
  end

  def booking_index
    @bookings = current_user.in_orders # 自己收到的订单
#    @codes.each do |code|
#      puts "self code ids >>> #{code.id}"
#    end
    maps = UserGroupMap.where(:up => current_user.user_group_id) # user_group ids
    maps.each do |map|
      user_group = UserGroup.find_by_id(map.down)
#      puts "map #{map} === #{user_group.name}"
      user_group.accounts.each do |account|
#        puts "  has a member = #{account.name} with #{account.invitation_codes.count} codes"
        @bookings += account.in_orders
      end
    end
    #@bookings = Booking.all
  end

  def new_tour
    @tour = Tour.new
    @sites = Site.all
    @covers = Image.where(image_type: "团队封面")
    @icons = Image.where(image_type: "团队图标")
  end

  def edit_tour
    @tours = Tour.all
    @sites = Site.all
    @images = Image.where(image_type: "景点照片")
    @covers = Image.where(image_type: "团队封面")
    @icons = Image.where(image_type: "团队图标")
    @tour = Tour.find_by_id(params[:id])
  end

  def decorate_tour
    @tours = Tour.all
    @images = Image.all
    @tour = Tour.find_by_id(params[:id])
  end

  def index_tour
    @tours = Tour.all
  end

  def new_shelf
    @shelf = Shelf.new
  end

  def edit_shelf
    @shelves = Shelf.all
    @shelf = Shelf.find_by_id(params[:id])
  end

  def index_shelf
    @shelves = Shelf.all
  end

  def tag_control
    @feature_tag = FeatureTag.new
    @feature_tags = FeatureTag.all
  end

  def date_and_price_control
    if params[:date_and_price_id] == "new"
      @date_and_price = DateAndPrice.new
    else
      @date_and_price = DateAndPrice.find_by_id(params[:date_and_price_id])
    end
    @tour = Tour.find_by_id(params[:tour_id])
    @tours = Tour.all
  end

  def image_admin
    @image = Image.new
    @images = Image.all
  end

  def new_site_admin
    @site = Site.new
    @images = Image.where(image_type: "景点照片")
    1.times { @site.image_and_sites.build }
  end

  def site_admin
    @site = Site.find_by_id(params[:id])
    @sites = Site.all
    @images = Image.all
  end

  def departure_admin
    if params[:departure_id] == "new"
      @departure = Departure.new
    else
      @departure = Departure.find_by_id(params[:departure_id])
    end
    @tour = Tour.find_by_id(params[:tour_id])
    @tours = Tour.all
    @user_groups = UserGroup.all
  end

  def price_admin
    if params[:price_id] == "new"
      @price = Price.new
      @departure = Departure.find_by_id(params[:departure_id])
      @tour = @departure.tour
    elsif params[:price_id].present?
      @price = Price.find_by_id(params[:price_id])
      @departure = @price.departure
      @tour = @departure.tour
    elsif params[:departure_id].present?
      @departure = Departure.find_by_id(params[:departure_id])
      @tour = @departure.tour
    elsif params[:tour_id].present?
      @tour = Tour.find_by_id(params[:tour_id])
    end
    
    
    @tours = Tour.all
    @user_groups = UserGroup.all
  end

  def sale_channels_admin
    @sale_channels = SaleChannel.all
  end

  def agents
    @agents = current_user.agents
  end

  def bookings_admin
    @bookings = current_user.in_orders
  end

  def my_invitation_code
    @user_classes = [ UserClass.find_by_id(5) ]
    @user_groups = UserGroupMap.desc_sale_channels(current_user.user_group_id)
    @sale_channels = SaleChannelMap.desc_sale_channels(current_user.sale_channel_id)
  end

  private
    def check_login
      redirect_to admin_signin_path unless staff_signed_in?
    end

end
