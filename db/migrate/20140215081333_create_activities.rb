class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :day_id
      t.integer :time
      t.string :active_type
      t.integer :site_id
      t.integer :image_id
      t.string :short_des
      t.text :full_des

      t.timestamps
    end
  end
end
