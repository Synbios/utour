class Admin::SessionsController < ApplicationController
  def new
    @account = Account.new
    render layout: false
  end

  def create
    # find by email
    @user = Account.find_by(email: params[:session][:email].downcase)

    if @user.nil?
      flash.now[:error] = '抱歉，您输入的用户名无法识别！'
      render 'new'
    elsif Account.authenticate_by_email(@user.email, params[:session][:password].downcase)
      sign_in @user
      flash[:success] = "登录成功"
      redirect_to "/admin#admin/home.html"
    else
      flash.now[:error] = '密码验证失败'
      render 'new'
    end
  end

  def destroy
    sign_out
    render 'new'
  end
end
