class AlterTourTable < ActiveRecord::Migration
  def change
  	remove_column :tours, :departure_date
  	remove_column :tours, :return_date
  	remove_column :tours, :visa_mailing_date
  	remove_column :tours, :ticket_issuing_date
  	remove_column :tours, :trade_price
  	remove_column :tours, :retail_price

  	rename_column :bookings, :tour_id, :date_and_price_id
  end
end
