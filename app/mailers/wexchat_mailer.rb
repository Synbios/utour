class WexchatMailer < ActionMailer::Base
  default from: "utouradmin@163.com"
 
  def booking_notice(account, booking)
    @account = account
    @booking = booking
    mail(to: @account.email, subject: "微分销客户预订通知 #{booking.id}")
  end

  def booking_notice_staff(customer, staff, booking)
    @customer = customer
    @staff = staff
    @booking = booking
    mail(to: @staff.email, subject: "微分销客户预订通知【预定号: #{booking.id}】")
  end

  def staff_welcome_email(account)
    @account = account
    mail(to: "#{'成都众信旅游'} <#{'utouradmin@163.com'}>", subject: "成都众信旅游客户预订通知")
  end

  def customer_welcome_email(account)
    @account = account
    mail(to: @account.email, subject: "微分销客户预订通知 #{booking.id}")
  end

  def trader_welcome_email(account)
    @account = account
    mail(to: @account.email, subject: "微分销客户预订通知 #{booking.id}")
  end

  def contact_message(name, contact, content)
    @name = name
    @contact = contact
    @content = content
    mail(to: "113655876@qq.com", subject: "微信网客户咨询")
  end

end
