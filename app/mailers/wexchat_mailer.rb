class WexchatMailer < ActionMailer::Base
  default from: "utouradmin@163.com"
 
  def booking_notice(account, booking)
    @account = account
    mail(to: @account.email, subject: "微分销客户预订通知 #{booking.id}")
  end

  def customer_welcome_email(account)
    @account = account
    mail(to: @account.email, subject: "微分销客户预订通知 #{booking.id}")
  end

  def trader_welcome_email(account)
    @account = account
    mail(to: @account.email, subject: "微分销客户预订通知 #{booking.id}")
  end
end
