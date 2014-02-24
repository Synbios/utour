class Admin::PricesController < ApplicationController
  def index
  end

  def new
  end

  def destroy
  end

  def update
  end

  def edit
  end

  def update
    @price = Price.find_by_id(params[:price_id])
    if @departure.update(departure_params)
    else
    end
  end

  def create
    @price = Price.new(price_params)
    @price.account = current_user
    if @price.save
      redirect_to "/admin#admin/price_admin.html?tour_id=#{@price.departure.id}&departure_id=#{params[:price][:departure_id]}"
    else
      redirect_to :back
    end
  end

  private
  def price_params
    params.require(:price).permit(:departure_id, :price, :number_of_seats, :user_group_id)
  end
end
