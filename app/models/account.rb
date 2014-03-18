class Account < ActiveRecord::Base
  attr_accessor :password, :activation_code, :is_trade

  has_attached_file :portray, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :portray, :content_type => /\Aimage\/.*\Z/

  has_attached_file :qr_code, :styles => { :medium => "300x300>", :thumb => "100x100" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :qr_code, :content_type => /\Aimage\/.*\Z/

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  MOBILE_REGEX = /\A\d{11}\z/
  validates :name, :presence => { :message => "姓名为必填" }, :length => { :in => 1..20, :message => "姓名过长" }
  validates :mobile, :presence => { :message => "手机号为必填" }, :uniqueness => { :message => "该手机号码已被注册" }, :format => { :with => MOBILE_REGEX, :message => "国内手机号须为11位数字" }
  validates :email, :presence => { :message => "电子邮箱为必填" }, :uniqueness => { :message => "该电子邮箱已被注册" }, :format => { :with => EMAIL_REGEX, :message => "电子邮箱格式非法" } 
  validates :gender, :presence => true, :inclusion => { :in => ["男", "女"], :message => "合法输入为”男“或”女“" }
  #validates :wechat_id, :presence => { :message => "微信号为必填" }, :uniqueness => { :message => "该微信号已被注册" }, :length => { :in => 6..30, :message => "微信号至少6位" }
#  validates :user_group_id, :presence => true



  validates :password, :presence => { :message => "密码为必填" }, :confirmation => { :message => "密码不一致" }, :length => { :minimum => 6, :message => "密码至少6位" }
  before_save :encrypt_password
  after_save :clear_password

  has_many :invitation_codes, foreign_key: :issued_by

  has_many :tours


  has_many :sale_agents, :class_name => 'SaleAgent', :foreign_key => 'sale_id'
  has_many :agents, :through => :sale_agents, :foreign_key => 'agent_id'

  has_many :agent_sales, :class_name => 'SaleAgent', :foreign_key => 'agent_id'
  has_many :sales, :through => :agent_sales, :foreign_key => 'sale_id'

  has_many :in_orders, :class_name => 'Booking', :foreign_key => 'sale_id'
  has_many :out_orders, :class_name => 'Booking', :foreign_key => 'agent_id'

  belongs_to :user_class
  belongs_to :user_group
  belongs_to :sale_channel

  #has_many :down_user_group_maps, :class_name => 'UserGroupMap', :through => :user_group, :foreign_key => 'agent_id'

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

  def self.authenticate_by_email(email, password)
    user = find_by_email(email)
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

  def user_class?(user_class_name)
    return true if self.user_class_id == 1 && user_class_name == :admin
    return true if self.user_class_id == 2 && user_class_name == :staff
    return true if self.user_class_id == 3 && user_class_name == :customer
    return false
  end

  def staff?
    return true if user_class_id == 2 || user_class_id == 3
    false
  end

  def activate(activation_code)
    
    return "该邀请码不适用于你的用户组" if self.user_class_id != activation_code.user_class_id
    return "该邀请码已被使用过" if activation_code.used
    return "该邀请码已过期" if Date.today > activation_code.expire_time
    return "你的账号不需激活，邀请码未使用" if self.active
    self.active = true;
    self.user_group_id = activation_code.user_group_id
    self.save
    activation_code.used = true;
    activation_code.save
    return "您的账号已被成功激活，邀请码已作废处理。"
  end

  def self.find_user_class_id_by_name(class_name)
    return 1 if class_name == :admin
    return 2 if class_name == :staff
    return 3 if class_name == :trade
    return 4 if class_name == :customer
    return 0
  end

  def self.user_class_name(user_class_id)
    return "管理员" if user_class_id == 1
    return "员工" if user_class_id == 2
    return "同行" if user_class_id == 3
    return "直客" if user_class_id == 4
    return "其他"
  end

  def trade?
    return true if self.user_class_id == 3
    false
  end

  def set_trade
    self.user_class_id = 3
  end

  def set_staff
    self.user_class_id = 2
  end

  def set_customer
    self.user_class_id = 4
  end

  def set_admin
    self.user_class_id = 1
  end


  def staff?
    return true if self.user_class_id < 5
    false
  end

  def agent?
    return true if self.user_class_id == 5
    false
  end

  def admin?
    return true if self.user_class_id == 1
    false
  end

  def self.sale_contact
    sales = Account.where(user_class_id: 4)
    if !sales.empty?
      return sales.sample.mobile
    else
      return GLOBAL["default_sale_phone"]
    end
  end

  # 根据团队和客户判定所需列举的销售
  def self.get_sales(price_id, agent_id)
    price = Price.find_by_id(price_id)
    agent = Account.find_by_id(agent_id)
    price_sale_channel = price.sale_channel

    sales = agent.sales
    sales.map do |sale|

    end
  end
end
