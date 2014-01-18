class CreateUserGroupHashes < ActiveRecord::Migration
  def change
    create_table :user_group_hashes do |t|
      t.integer :user_group_id
      t.integer :belongs_to
      t.integer :premission

      t.timestamps
    end
  end
end
