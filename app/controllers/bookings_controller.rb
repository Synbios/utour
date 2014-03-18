class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :check_login


  # GET /bookings
  # GET /bookings.json
  def index
    @account = current_user
    if @account.nil?
      store_location
      redirect_to :controller=> 'sessions', :action => 'new'
    else
      

      @bookings = @account.out_orders
      @tours = @bookings.map { |booking| booking.price.departure.tour }.uniq { |tour| tour.id }
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{@account.id} #{@bookings} #{@tours}"
    end
  end

  def account_specific_index
    @bookings = Booking.all#account.booking
  end
  # GET /bookings/1
  # GET /bookings/1.json
  def show

  end

  # GET /bookings/new
  def new
    @booking = Booking.new
    #@booking.number_of_adults = 0
    #@booking.number_of_children = 0
    if params[:price_id].present?
      @booking.price_id = params[:price_id]
      @sales = current_user.sales #Account.get_sales(params[:price_id], current_user.id)
      @price = Price.find_by_id(params[:price_id])
      @tour = Tour.find_by_id(@price.departure.tour_id)
    end
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.agent = current_user

    @booking.number_of_adults = 0 if params[:booking][:number_of_adults].blank?
    @booking.number_of_children = 0 if params[:booking][:number_of_children].blank?
    # 直客报名
    @booking.sale = Account.find_by_id(GLOBAL["default_retail_sale_id"]) if params[:booking][:sale_id].nil?
    @booking.progress = "未处理"
    @booking.confirmed_seats = 0
    respond_to do |format|
      if @booking.save
        # WexchatMailer.booking_notice(@booking.account)
        WexchatMailer.booking_notice_staff(@booking.agent, @booking.sale, @booking).deliver
        format.html { redirect_to bookings_path, notice: '预订成功' }
        format.js { render :status => :created, :location => @booking, :layout => false }
      else
        puts ">>>>>>>>>>>>>>>>>#{@booking.errors.full_messages}"
        format.html { 
          @sales = current_user.sales
          @price = @booking.price
          @tour = @booking.price.departure.tour
          render 'new', price_id: @booking.price_id
        }
        format.js { 
          puts "booking save error processing js"
          render :status => :unprocessable_entity, :layout => false

        }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:number_of_adults, :number_of_children, :price_id, :sale_id, :agent_id, :comment, :progress)
    end
end
