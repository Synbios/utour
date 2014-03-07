class AddDepartureCityToTours < ActiveRecord::Migration
  def change
    add_column :tours, :departure_city, :string
  end
end
