class Admin::DeparturesController < ApplicationController
  def index
    @tour = Tour.find_by_id(params[:tour_id])
    render partial: "index", locals: { tour: @tour }, layout: false
  end

  def new
    @departure = Departure.new
    @tour = Tour.find_by_id(params[:tour_id])
    render partial: "form", locals: { tour: @tour, departure: @departure }, layout: false
  end

  def destroy
  end

  def update
    @departure = Departure.find_by_id(params[:id])
    if @departure.update(departure_params)
      redirect_to "/admin#" + admin_tour_departures_path(@departure.tour)
    else
      render partial: "form", locals: { tour: @tour, departure: @departure }, layout: false
    end
  end

  def edit
    @departure = Departure.find_by_id(params[:id])
    @tour = @departure.tour
    render partial: "form", locals: { tour: @tour, departure: @departure }, layout: false
  end

  def create
    @departure = Departure.new(departure_params)
    @departure.account = current_user
    if @departure.save
      redirect_to "/admin#" + admin_tour_departures_path(@departure.tour)
    else
      render partial: "form", locals: { tour: @tour, departure: @departure }, layout: false
    end
  end

  private
  def departure_params
    params.require(:departure).permit(:tour_id, :date, :number_of_seats, :sale_channel_id, :expire_date, :visa_status, :group_notice)
  end
end
