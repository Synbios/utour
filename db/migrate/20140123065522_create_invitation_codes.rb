class CreateInvitationCodes < ActiveRecord::Migration
  def change
    create_table :invitation_codes do |t|
      t.integer :account_id
      t.integer :user_class_id
      t.integer :user_group_id
      t.datetime :expire_time
      t.boolean :used

      t.timestamps
    end

    drop_table :invitaion_codes
  end
end
