class AddFeaturesToTour < ActiveRecord::Migration
  def change
    add_column :tours, :erp_features, :text
  end
end
