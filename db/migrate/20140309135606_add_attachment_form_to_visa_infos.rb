class AddAttachmentFormToVisaInfos < ActiveRecord::Migration
  def self.up
    change_table :visa_infos do |t|
      t.attachment :form
    end
  end

  def self.down
    drop_attached_file :visa_infos, :form
  end
end
