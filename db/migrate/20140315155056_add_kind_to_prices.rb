class AddKindToPrices < ActiveRecord::Migration
  def change
    add_column :prices, :kind, :string
  end
end
