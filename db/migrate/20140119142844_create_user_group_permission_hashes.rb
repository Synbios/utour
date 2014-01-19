class CreateUserGroupPermissionHashes < ActiveRecord::Migration
  def change
    create_table :user_group_permission_hashes do |t|
      t.integer :user_group_id
      t.integer :allowed_user_group_id

      t.timestamps
    end
  end
end
