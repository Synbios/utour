class Admin::PricesController < ApplicationController
  def index
    @departure = Departure.find_by_id(params[:departure_id])
    @tour = @departure.tour
    render partial: "index", locals: { tour: @tour, departure: @departure }, layout: false
  end

  def new
    @price = Price.new
    @departure = Departure.find_by_id(params[:departure_id])
    @tour = @departure.tour
    render partial: "form", locals: { tour: @tour, departure: @departure, price: @price }, layout: false
  end

  def destroy
  end

  def edit
    @price = Price.find_by_id(params[:id])
    @departure = @price.departure
    @tour = @departure.tour
    render partial: "form", locals: { tour: @tour, departure: @departure, price: @price }, layout: false
  end

  def update
    @price = Price.find_by_id(params[:id])
    if @price.update(price_params)
      redirect_to "/admin#" + admin_tour_departure_prices_path(@price.departure.tour, @price.departure)
    else
      render partial: "form", locals: { tour: @tour, departure: @departure, price: @price }, layout: false
    end
  end

  def create
    @price = Price.new(price_params)
    @price.account = current_user
    if @price.save
      redirect_to "/admin#" + admin_tour_departure_prices_path(@price.departure.tour, @price.departure)
    else
      render partial: "form", locals: { tour: @tour, departure: @departure, price: @price }, layout: false
    end
  end

  private
  def price_params
    params.require(:price).permit(:departure_id, :price, :number_of_seats, :sale_channel_id, :expire_date)
  end
end
