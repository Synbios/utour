class AddConfiremedSeatsToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :confirmed_seats, :integer
  end
end
