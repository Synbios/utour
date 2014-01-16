class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :mobile
      t.string :email
      t.string :gender
      t.string :wechat_id
      t.string :user_group
      t.string :encrypted_password
      t.string :salt
      t.string :memory_token

      t.timestamps
    end
  end
end
