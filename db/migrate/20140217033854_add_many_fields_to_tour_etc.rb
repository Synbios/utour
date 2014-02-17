class AddManyFieldsToTourEtc < ActiveRecord::Migration
  def change
  	add_column :days, :breakfast, :string
  	add_column :days, :lunch, :string
  	add_column :days, :dinner, :string
  	add_column :days, :itinerary, :text

  	add_column :tours, :include, :text
  	add_column :tours, :exclude, :text
  	add_column :tours, :transportations, :text
  	add_column :tours, :notes, :text
  	add_column :tours, :visa, :text
  end
end
