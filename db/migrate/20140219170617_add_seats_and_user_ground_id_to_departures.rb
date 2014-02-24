class AddSeatsAndUserGroundIdToDepartures < ActiveRecord::Migration
  def change
  	add_column :departures, :number_of_seats, :integer
  	add_column :departures, :user_group_id, :integer
  end
end
