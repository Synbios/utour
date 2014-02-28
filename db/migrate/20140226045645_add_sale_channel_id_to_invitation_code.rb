class AddSaleChannelIdToInvitationCode < ActiveRecord::Migration
  def change
    add_column :invitation_codes, :sale_channel_id, :integer
  end
end
