class AddParentIdToSaleChannels < ActiveRecord::Migration
  def change
  	add_column :sale_channels, :parent_id, :integer
  end
end
