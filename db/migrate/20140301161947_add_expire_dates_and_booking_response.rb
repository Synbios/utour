class AddExpireDatesAndBookingResponse < ActiveRecord::Migration
  def change
    add_column :tours, :expire_date, :datetime
    add_column :departures, :expire_date, :datetime
    add_column :prices, :expire_date, :datetime
    add_column :bookings, :progress_id, :integer
    add_column :bookings, :response, :text
  end
end
