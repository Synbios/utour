class AlterBookingTable < ActiveRecord::Migration
  def change
  	add_column :bookings, :number_of_children, :integer
  	add_column :bookings, :number_of_adults, :integer
  	add_column :bookings, :comment, :string
  	remove_column :bookings, :number_of_people
  	remove_column :bookings, :package_id
  	remove_column :bookings, :departure_date

  end
end
