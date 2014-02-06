class CreateFeatureTagConnections < ActiveRecord::Migration
  def change
    create_table :feature_tag_connections do |t|
      t.integer :parent_tag_id
      t.integer :child_tag_id
      t.integer :account_id

      t.timestamps
    end
  end
end
