class ChangeTourTable < ActiveRecord::Migration
  def change
  	add_column :tours, :description, :string
  	add_column :tours, :type, :string
  end
end
