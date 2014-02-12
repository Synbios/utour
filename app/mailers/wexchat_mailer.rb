class WexchatMailer < ActionMailer::Base
  default from: "utouradmin@163.com"
  layout 'utourmail' # use utourmail.(html|text).erb as the layout

  # 微信预订通知邮件
  def booking_notice_staff(customer, staff, booking)
    @customer = customer
    @staff = staff
    @booking = booking
    mail(to: @staff.email, subject: "微分销客户预订通知【预定号: #{booking.id}】")
  end

  # 员工注册欢迎邮件
  def staff_welcome_email(account)
    @account = account
    mail(to: "#{'成都众信旅游'} <#{'utouradmin@163.com'}>", subject: "成都众信旅游客户预订通知")
  end

  # 直客注册欢迎邮件
  def customer_welcome_email(account)
    @account = account
    mail(to: @account.email, subject: "微分销客户预订通知 #{booking.id}")
  end

  # 同行注册欢迎邮件
  def trader_welcome_email(account)
    @account = account
    mail(to: @account.email, subject: "微分销客户预订通知 #{booking.id}")
  end

  # 网页咨询文件(不需注册)
  def contact_message(name, contact, content)
    @name = name
    @contact = contact
    @content = content
    mail(to: "zhouyou@utourworld.com", subject: "微信网客户咨询")
  end

end
