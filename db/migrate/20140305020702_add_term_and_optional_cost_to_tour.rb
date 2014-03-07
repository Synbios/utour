class AddTermAndOptionalCostToTour < ActiveRecord::Migration
  def change
    add_column :tours, :other_options, :text
    add_column :tours, :terms, :text
  end
end
