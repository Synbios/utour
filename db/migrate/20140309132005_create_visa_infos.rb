class CreateVisaInfos < ActiveRecord::Migration
  def change
    create_table :visa_infos do |t|
      t.string :country
      t.text :requirements
      t.text :notes

      t.timestamps
    end
  end
end
