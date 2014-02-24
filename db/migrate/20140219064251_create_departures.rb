class CreateDepartures < ActiveRecord::Migration
  def change
    create_table :departures do |t|
      t.integer :tour_id
      t.date :date
      t.string :visa_status
      t.string :notification

      t.timestamps
    end
  end
end
