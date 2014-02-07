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

  def applicable?(account)
    return false if status[:state] != :ok
    return false if user_class_id != 1 && account.user_class_id != user_class_id
    true
  end
  def use(account)
    return false unless applicable?(account)
    account.update_columns(user_group_id: user_group_id)
    account.update_columns(user_class_id: user_class_id)
    self.update_columns(used_by: account.id)
    self.update_columns(used_at: Time.now)
    return true
  end
end
