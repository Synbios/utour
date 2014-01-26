module SessionsHelper

  # initialize a new session
  def sign_in(user)
    remember_token = Account.new_remember_token # get a new session token
    cookies.permanent[:memory_token] = remember_token # store new token in user's cookies
    user.update_attribute(:memory_token, Account.encrypt(remember_token)) # update token in database
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end
	
  def admin?
    user = current_user
    if !user.nil?
      return user.admin?
    end
    return false
  end

	def current_user
    remember_token = Account.encrypt(cookies[:memory_token])
    @current_user ||= Account.find_by(memory_token: remember_token)
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:memory_token)
  end

  def account_filter(user_class_name, user_group)
    account = current_user
    return nil if account.nil?
    return nil unless account.user_class_id = Account.find_user_class_id_by_name(user_class_name)
    return nil unless user_group == :all
    return account
  end
end
