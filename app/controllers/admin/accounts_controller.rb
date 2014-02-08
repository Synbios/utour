class Admin::AccountsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def new
    @account = Account.new
    render layout: false
  end

  def create
    @account = Account.new(account_params)
    @account.user_class_id = 2
    if params[:gender] == 2
      @account.gender = "女"
    else
      @account.gender = "男"
    end
    
    invitation_code = InvitationCode.find_by_code(params[:invitation_code])
    if !invitation_code.nil? && invitation_code.applicable?(@account)
      respond_to do |format|
        if @account.save
          format.html {
            invitation_code.use(@account)
            sign_in @account
            redirect_to '/admin#admin/home.html'
          } 
        else
          format.html {
            render 'new', layout: false
          }
        end
      end
    else
      @account.errors[:invitation_code] = "注册码错误"
      render 'new', layout: false
    end
  end

  def destroy
    @account = Account.find_by_id(params[:id])
    @account.destroy
    respond_to do |format|
      format.html { redirect_to '/admin#admin/account_admin.html' }
      format.js
    end
  end

  def index
    @admin_accounts = Account.where(user_class_id: 1)
    @staff_accounts = Account.where(user_class_id: 2)
    @trade_accounts = Account.where(user_class_id: 3)
    @customer_accounts = Account.where(user_class_id: 4)
    respond_to do |format|
      format.js
      #format.html { render }
    end
  end

  
  private
    def account_params
      params.require(:account).permit(:name, :mobile, :email, :gender, :wechat_id, :password, :password_confirmation, :memory_token)
    end
end
