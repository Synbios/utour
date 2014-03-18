class ChangeUpAndDownInSaleChannelMaps < ActiveRecord::Migration
  def change
    rename_column :sale_channel_maps, :up, :up_id
    rename_column :sale_channel_maps, :down, :down_id
  end
end
