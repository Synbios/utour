class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :departure_date
      t.integer :number_of_people
      t.string :package_id
      t.integer :tour_id

      t.timestamps
    end
  end
end
