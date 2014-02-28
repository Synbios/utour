class AddPictureAttachmentsToAccount < ActiveRecord::Migration
  def self.up
    add_attachment :accounts, :portray
    add_attachment :accounts, :qr_code
  end

  def self.down
    remove_attachment :accounts, :portray
    remove_attachment :accounts, :qr_code
  end
end
