class AddAttachmentGroupNoticeToDepartures < ActiveRecord::Migration
  def self.up
    change_table :departures do |t|
      t.attachment :group_notice
    end
  end

  def self.down
    drop_attached_file :departures, :group_notice
  end
end
