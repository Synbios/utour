class ChangeValidInInvitationCodeTable < ActiveRecord::Migration
  def change
  	rename_column :invitation_codes, :valid, :cancelled
  end
end
