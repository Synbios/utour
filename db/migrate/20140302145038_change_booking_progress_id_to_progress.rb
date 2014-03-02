class ChangeBookingProgressIdToProgress < ActiveRecord::Migration
  def change
    remove_column :bookings, :progress_id
    add_column :bookings, :progress, :string
  end
end
