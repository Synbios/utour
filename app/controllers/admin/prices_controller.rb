class Admin::PricesController < ApplicationController
  def index
    @departure = Departure.find_by_id(params[:departure_id])
    @tour = @departure.tour
    render partial: "index", locals: { tour: @tour, departure: @departure }, layout: false
  end

  def new
    @price = Price.new
    @departure = Departure.find_by_id(params[:departure_id])
    @price.expire_date = @departure.expire_date
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
    params[:expire_date] = @price.departure.expire_date if params[:expire_date].present? &&  Date.new(params[:expire_date]) > @price.departure.expire_date
    if @price.update(price_params)
      @price.update_attribute(:expire_date, @price.departure.expire_date) if @price.expire_date > @price.departure.expire_date
      redirect_to "/admin#" + admin_tour_departure_prices_path(@price.departure.tour, @price.departure)
    else
      redirect_to "/admin#" + edit_admin_tour_departure_price_path(@price.departure.tour, @price.departure, @price), :flash => { :error => @price.errors.full_messages.to_sentence }
      #render partial: "form", locals: { tour: @tour, departure: @departure, price: @price }, layout: false
    end
  end

  def create
    @departure = Departure.find params[:departure_id]
    @price = Price.new(price_params)
    @price.departure = @departure
    @price.account = current_user
    if @price.save
      @price.update_attribute(:expire_date, @price.departure.expire_date) if @price.expire_date > @price.departure.expire_date
      redirect_to "/admin#" + admin_tour_departure_prices_path(@price.departure.tour, @price.departure)
    else
      redirect_to "/admin#" + new_admin_tour_departure_price_path(@price.departure.tour, @price.departure), :flash => { :error => @price.errors.full_messages.to_sentence }
      #render partial: "form", locals: { tour: @tour, departure: @departure, price: @price }, layout: false
    end
  end

  private
  def price_params
    params.require(:price).permit(:departure_id, :price, :number_of_seats, :sale_channel_id, :expire_date, :kind)
  end
end
