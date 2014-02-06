class InvitationCode < ActiveRecord::Base
  # check the code's current status
  # ok, used, expired, cancelled and a chinese message
  def status
    msg = ""
    state = :ok
    if self.used_at.nil? == false
      msg += "已使用"
      state = :used
    end
    if Time.now > self.expire_time
      msg += "已过期"
      state = :expired
    end
    if self.cancelled == true
      msg += "已作废"
      state = :cancelled
    end
    return { state: state, message: msg }
  end
end
