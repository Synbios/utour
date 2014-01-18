class ChangeUserGroupInAccount < ActiveRecord::Migration
  def change
  	remove_column :accounts, :user_group
  	add_column :accounts, :premission_tag_id, :integer
  end
end
