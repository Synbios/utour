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

  def staff_signed_in?
    user = current_user
    return false if user.nil?
    return false unless user.staff? || user.admin?
    true
  end

	def current_user
    remember_token = Account.encrypt(cookies[:memory_token])
    @current_user ||= Account.find_by(memory_token: remember_token)
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:memory_token)
  end

  # 
  def account_filter(user_class_name, user_group)
    account = current_user
    return nil if account.nil?
    return nil unless account.user_class_id = Account.find_user_class_id_by_name(user_class_name)
    return nil unless user_group == :all
    return account
  end

  def trade_or_staff?
    account = current_user
    return account if !account.nil? && (account.trade? || account.staff? || account.admin? )
    nil
  end

  def inspect_right(tour)
    account = current_user
    if account.nil?
      return :customer
    elsif
      user_group_ids = tour.tour_group.split
      user_group_ids.each do |id|
        return :trade if UserGroupPermissionHash.where(user_group_id: id, allowed_user_group_id: account.user_group_id).present?
      end
      return :customer
    else
      return :customer
    end
  end

  def store_location   
    session[:return_to] = request.original_url
  end

  def check_login
    if !signed_in?
      store_location
      redirect_to :controller=> 'sessions', :action => 'new'
    # elsif current_user.active != true
    #   store_location
    #   redirect_to activate_show_account_path(current_user)
    end
  end

  
  # Redirect to the URI stored by the most recent store_location call or  
  # to the passed default.  
  def redirect_back_or_default(default=root_url)  
    redirect_to(session[:return_to] || default)  
    session[:return_to] = nil  
  end 
end
