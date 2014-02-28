class ChangeGroupIdToSaleChannelIdInTourDepartureAndPrice < ActiveRecord::Migration
  def change
  	rename_column :tours, :user_group_id, :sale_channel_id
  	rename_column :departures, :user_group_id, :sale_channel_id
  	rename_column :prices, :user_group_id, :sale_channel_id
  end
end
