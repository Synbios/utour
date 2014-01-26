class AddAccountIdToTour < ActiveRecord::Migration
  def change

  	add_column :tours, :group, :string
  	add_column :tours, :sale_state, :string
  	change_column :tours, :content, :text
  end
end
