class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.string :identifier
      t.string :name
      t.string :content
      t.date :departure_date
      t.date :return_date
      t.date :visa_mailing_date
      t.date :ticket_issuing_date
      t.decimal :trade_price
      t.decimal :retail_price

      t.timestamps
    end
  end
end
