class CreateFeatureTags < ActiveRecord::Migration
  def change
    create_table :feature_tags do |t|
      t.string :name
      t.integer :depth

      t.timestamps
    end
  end
end
