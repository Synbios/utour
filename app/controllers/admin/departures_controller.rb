class Admin::DeparturesController < ApplicationController
  def index
  end

  def new
  end

  def destroy
  end

  def update
    @departure = Departure.find_by_id(params[:departure_id])
    if @departure.update(departure_params)
    else
    end
  end

  def edit
  end

  def create
    @departure = Departure.new(departure_params)
    @departure.account = current_user
    if @departure.save
      redirect_to "/admin#admin/departure_admin.html?tour_id=#{params[:departure][:tour_id]}"
    else
      redirect_to :back
    end
  end

  private
  def departure_params
    params.require(:departure).permit(:tour_id, :date, :number_of_seats, :user_group_id)
  end
end
