class SessionsController < ApplicationController
  def new
  end

  def create
    # find by email, mobile phone number or wechat id
    @user = Account.find_by(email: params[:session][:identification_id].downcase)
    @user = Account.find_by(mobile: params[:session][:identification_id].downcase) if @user.nil?
    @user = Account.find_by(wechat_id: params[:session][:identification_id].downcase) if @user.nil?

    if @user.nil?
      flash.now[:error] = '无法识别'
      render text: "NO"
    elsif Account.authenticate_by_id(@user.id, params[:session][:password].downcase)
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user 
      #render text: "search #{signed_in?}"
    else
      flash.now[:error] = '用户名或密码无效'
      render text: "NO"
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
