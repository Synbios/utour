class ChangeTourAttributeName < ActiveRecord::Migration
  def change
  	rename_column :tours, :type, :tour_type
    rename_column :tours, :group, :tour_group
  end
end
