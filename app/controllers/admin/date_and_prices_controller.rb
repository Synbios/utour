class Admin::DateAndPricesController < ApplicationController

	def create
		@date_and_price = DateAndPrice.new
    @date_and_price.tour_id = params[:date_and_price][:tour_id]
    @date_and_price.departure_date = params[:date_and_price][:departure_date]
    @date_and_price.trade_price = params[:date_and_price][:trade_price]
    @date_and_price.retail_price = params[:date_and_price][:retail_price]
    @date_and_price.export = 1
    if @date_and_price.save
      redirect_to "/admin#admin/date_and_price_control.html?tour_id=#{params[:date_and_price][:tour_id]}"
    else
      redirect_to :back
    end
	end
end
