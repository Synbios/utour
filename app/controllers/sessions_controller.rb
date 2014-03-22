class SessionsController < ApplicationController
  def new
    # if params[:user_class] == "trade"
    #   render 'sessions/new/trade'
    # elsif params[:user_class] == "customer"
    #   render 'sessions/new/customer'
    # elsif params[:user_class] == "staff"
    #   render 'sessions/new/staff'
    # end
    if current_user.present?
      redirect_to root_path 
    else
      render 'sessions/new' # 同业和直客通用同一登录界面
    end
  end

  def create
    # find by email, mobile phone number or wechat id
    @user = Account.find_by(email: params[:session][:identification_id].downcase)
    @user = Account.find_by(mobile: params[:session][:identification_id].downcase) if @user.nil?
    #@user = Account.find_by(wechat_id: params[:session][:identification_id].downcase) if @user.nil?

    if @user.nil?
      flash.now[:error] = '抱歉，您输入的用户名无法识别！'
      render 'new'
    elsif Account.authenticate_by_id(@user.id, params[:session][:password].downcase)
      sign_in @user
      flash[:success] = "登录成功"
      
      #redirect_to session.delete(:return_to) 
      redirect_back_or_default
    else
      flash.now[:error] = '密码验证失败'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
