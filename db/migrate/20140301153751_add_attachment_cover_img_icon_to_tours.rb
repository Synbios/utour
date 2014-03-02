class AddAttachmentCoverImgIconToTours < ActiveRecord::Migration
  def self.up
    change_table :tours do |t|
      t.attachment :cover_img
      t.attachment :icon
    end
  end

  def self.down
    drop_attached_file :tours, :cover_img
    drop_attached_file :tours, :icon
  end
end
