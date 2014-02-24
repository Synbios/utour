class AddPriceToBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :price_id, :integer
  end
end
