class AddUserClassToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :user_class_id, :integer
  end
end
