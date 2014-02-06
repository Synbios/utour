class AddCodeToInvitationCodeTable < ActiveRecord::Migration
  def change
  	add_column :invitation_codes, :code, :string
  end
end
