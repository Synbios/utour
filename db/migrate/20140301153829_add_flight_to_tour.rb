class AddFlightToTour < ActiveRecord::Migration
  def change
    remove_column :tours, :content
    add_column :tours, :flights, :string
  end
end
