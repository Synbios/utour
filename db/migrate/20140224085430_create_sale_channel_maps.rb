class CreateSaleChannelMaps < ActiveRecord::Migration
  def change
    create_table :sale_channel_maps do |t|
      t.integer :up
      t.integer :down
      t.integer :distance

      t.timestamps
    end
  end
end
