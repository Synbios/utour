class AddManyAttributesToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :sale_channel_id, :integer
    add_column :accounts, :company_name, :string
    add_column :accounts, :qr_code_url, :string
    add_column :accounts, :open_id, :string
    add_column :accounts, :wechat_province, :string
    add_column :accounts, :wechat_city, :string
    add_column :accounts, :wechat_head_url, :string
  end
end
