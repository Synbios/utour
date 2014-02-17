class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :short_des
      t.text :full_des

      t.timestamps
    end
  end
end
