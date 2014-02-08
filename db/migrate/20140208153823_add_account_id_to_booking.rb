class AddAccountIdToBooking < ActiveRecord::Migration
  def change
  	add_column :bookings, :account_id, :integer
  end
end
