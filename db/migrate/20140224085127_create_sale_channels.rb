class CreateSaleChannels < ActiveRecord::Migration
  def change
    create_table :sale_channels do |t|
      t.string :name
      t.string :abb

      t.timestamps
    end
  end
end
