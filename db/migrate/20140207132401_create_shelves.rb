class CreateShelves < ActiveRecord::Migration
  def change
    create_table :shelves do |t|
      t.string :name
      t.text :rack

      t.timestamps
    end
  end
end
