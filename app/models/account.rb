class Account < ActiveRecord::Base
  attr_accessor :password

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  MOBILE_REGEX = /\A\d{11}\z/
  validates :name, :presence => { :message => "姓名为必填" }, :length => { :in => 1..20, :message => "姓名过长" }
  validates :mobile, :presence => { :message => "手机号为必填" }, :uniqueness => { :message => "该手机号码已被注册" }, :format => { :with => MOBILE_REGEX, :message => "国内手机号须为11位数字" }
  validates :email, :presence => { :message => "电子邮箱为必填" }, :uniqueness => { :message => "该电子邮箱已被注册" }, :format => { :with => EMAIL_REGEX, :message => "电子邮箱格式非法" } 
  validates :gender, :presence => true, :inclusion => { :in => ["男", "女"], :message => "合法输入为”男“或”女“" }
  validates :wechat_id, :presence => { :message => "微信号为必填" }, :uniqueness => { :message => "该微信号已被注册" }, :length => { :in => 6..30, :message => "微信号至少6位" }
  validates :user_group, :presence => true

  validates :password, :presence => { :message => "密码为必填" }, :confirmation => { :message => "密码不一致" }, :length => { :minimum => 6, :message => "密码至少6位" }
  before_save :encrypt_password
  after_save :clear_password

  has_many :invitaion_codes

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  def clear_password
    self.password = nil
  end

  def self.authenticate_by_id(id, password)
    user = find_by_id(id)
    if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end

  def Account.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Account.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  def create_remember_token
    self.remember_token = Account.encrypt(Account.new_remember_token)
  end

  def admin?
    if self.user_group == 'admin'
      return true
    end
    return false
  end

end
