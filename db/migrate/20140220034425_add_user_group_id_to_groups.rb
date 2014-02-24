class AddUserGroupIdToGroups < ActiveRecord::Migration
  def change
  	add_column :tours, :user_group_id, :integer
  end
end
