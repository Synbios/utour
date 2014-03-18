class ChangeUpAndDownInUserGroupMaps < ActiveRecord::Migration
  def change
    rename_column :user_group_maps, :up, :up_id
    rename_column :user_group_maps, :down, :down_id
  end
end
