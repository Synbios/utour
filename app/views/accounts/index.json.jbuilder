json.array!(@accounts) do |account|
  json.extract! account, :id, :name, :mobile, :email, :gender, :wechat_id, :user_group, :encrypted_password, :salt, :memory_token
  json.url account_url(account, format: :json)
end
