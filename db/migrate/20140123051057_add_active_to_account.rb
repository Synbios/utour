class AddActiveToAccount < ActiveRecord::Migration
  def change
  	remove_column :accounts, :superuser
  	add_column :accounts, :active, :boolean
  end
end
