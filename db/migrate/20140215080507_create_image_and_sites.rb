class CreateImageAndSites < ActiveRecord::Migration
  def change
    create_table :image_and_sites do |t|
      t.integer :image_id
      t.integer :site_id

      t.timestamps
    end
  end
end
