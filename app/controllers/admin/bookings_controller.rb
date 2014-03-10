class Admin::BookingsController < ApplicationController
  before_action :set_booking, only: [:update, :show, :edit]
  layout false

  def edit
    render partial: "form", locals: { booking: @booking }
  end

  def update
    if @booking.update(booking_params)
      redirect_to "/admin#admin/bookings_admin.html"
    else
      redirect_to "/admin#" + edit_admin_booking_path(@booking), :flash => { :error => @booking.errors.full_messages.to_sentence }
      #render partial: "form", locals: { booking: @booking }
    end
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:number_of_adults, :number_of_children, :price_id, :sale_id, :agent_id, :comment, :progress, :response, :confirmed_seats)
    end
end
