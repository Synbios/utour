class CreateUserGroupMaps < ActiveRecord::Migration
  def change
    create_table :user_group_maps do |t|
      t.integer :up
      t.integer :down
      t.integer :distance

      t.timestamps
    end
  end
end
