class ChangeActivityTimeToString < ActiveRecord::Migration
  def change
  	change_column :activities, :time, :string
  end
end
