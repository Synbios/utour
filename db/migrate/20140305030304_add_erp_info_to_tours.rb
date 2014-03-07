class AddErpInfoToTours < ActiveRecord::Migration
  def change
    add_column :tours, :erp_info, :text
  end
end
