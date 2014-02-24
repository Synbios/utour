class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :departure_id
      t.decimal :price
      t.integer :user_group_id
      t.integer :account_id

      t.timestamps
    end
  end
end
