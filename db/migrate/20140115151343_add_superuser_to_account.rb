class AddSuperuserToAccount < ActiveRecord::Migration
  def change
  	add_column :accounts, :superuser, :boolean
    add_column :tours, :account_id, :integer
  end
end
