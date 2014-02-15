class AddUserGroupToDateAndPrice < ActiveRecord::Migration
  def change
  	add_column :date_and_prices, :user_groups, :string
  end
end
