class AlterAccountTable < ActiveRecord::Migration
  def change
  	rename_column :accounts, :user_group, :user_group_id
  end
end
