class AddIdentifierToDeparture < ActiveRecord::Migration
  def change
    add_column :departures, :identifier, :string
  end
end
