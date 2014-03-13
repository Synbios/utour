class AddAlterErpToTours < ActiveRecord::Migration
  def change
    add_column :tours, :erp_more_info, :text
    add_column :tours, :word_url, :string
  end
end
