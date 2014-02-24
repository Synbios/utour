class AddUserGroupIdToDepartures < ActiveRecord::Migration
  def change
  	add_column :departures, :account_id, :integer
  end
end
