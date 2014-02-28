class RedoBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :account_id
    add_column :bookings, :agent_id, :integer
    add_column :bookings, :sale_id, :integer
  end
end
