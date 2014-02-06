class AlterInvitationCodeTable < ActiveRecord::Migration
  def change
  	remove_column :invitation_codes, :account_id
  	remove_column :invitation_codes, :used
  	add_column :invitation_codes, :issued_by, :integer
  	add_column :invitation_codes, :used_by, :integer
  	add_column :invitation_codes, :used_at, :datetime
  	add_column :invitation_codes, :valid, :boolean
  end
end
