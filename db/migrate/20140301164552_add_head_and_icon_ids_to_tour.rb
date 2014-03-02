class AddHeadAndIconIdsToTour < ActiveRecord::Migration
  def self.up
    drop_attached_file :tours, :cover_img
    drop_attached_file :tours, :icon
    add_column :tours, :cover_img_id, :integer
    add_column :tours, :icon_img_id, :integer
  end

  def self.down
    change_table :tours do |t|
      t.attachment :cover_img
      t.attachment :icon
    end
    
    remove_column :tours, :cover_img_id
    remove_column :tours, :icon_img_id
  end
end
