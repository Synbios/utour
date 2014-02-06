class CreateDateAndPrices < ActiveRecord::Migration
  def change
    create_table :date_and_prices do |t|
      t.integer :tour_id
      t.date :departure_date
      t.date :return_date
      t.date :visa_mailing_date
      t.date :ticket_issuing_date
      t.decimal :trade_price
      t.decimal :retail_price
      t.boolean :export

      t.timestamps
    end
  end
end
