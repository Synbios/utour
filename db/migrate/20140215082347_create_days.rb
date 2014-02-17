class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :tour_id
      t.integer :number
      t.string :accommodation

      t.timestamps
    end
  end
end
