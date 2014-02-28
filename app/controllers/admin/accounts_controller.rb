class Admin::AccountsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def new
    @account = Account.new
    render layout: false
  end

  # 注册后台用户: 系统管理, 管理, 销售和操作
  def create
    @account = Account.new(account_params)
    if params[:gender] == 2
      @account.gender = "女"
    else
      @account.gender = "男"
    end
    
    invitation_code = InvitationCode.find_by_code(params[:invitation_code])

    if invitation_code.user_class_id != @account.user_class_id
      @account.errors[:invitation_code] = "该注册码不匹配所申请注册用户类型"
      render 'new', layout: false
    elsif invitation_code.status[:state] != :ok
      @account.errors[:invitation_code] = "注册码#{invitation_code.status[:message]}"
      render 'new', layout: false
    else
      @account.user_class_id = invitation_code.user_class_id
      @account.user_group_id = invitation_code.user_group_id
      @account.sale_channel_id = invitation_code.sale_channel_id
      if @account.save
        invitation_code.use(self)
        WexchatMailer.staff_welcome_email(@account).deliver
        format.html {
          invitation_code.use(@account)
          sign_in @account
          redirect_to '/admin#admin/home.html'
        }
      else
        render 'new', layout: false
      end
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
    respond_to do |format|
      format.js {
        if params[:type] == "staff"
          @accounts = Account.where("user_class_id <= 4")
          #puts ">>>>>>>>#{@accounts.count}"
          @accounts.map! do |account|
            #puts "account = #{account.name}"
            if account.id == current_user.id || UserGroupMap.where(up: current_user.user_group_id, down: account.user_group_id).count > 0
              #puts "OK"
              account
            else
              #puts "NO"
              nil
            end
          end
          #puts ">>>#{@account}"
          @accounts.compact!
          render 'staff_index'
        elsif params[:type] == "agent"
          @accounts = Account.where("user_class_id > 4")
          @accounts.map! do |account|
            #puts "account = #{account.name}"
            if account.id == current_user.id || UserGroupMap.where(up: current_user.user_group_id, down: account.user_group_id).count > 0
              #puts "OK"
              account
            else
              #puts "NO"
              nil
            end
          end
          #puts ">>>#{@account}"
          @accounts.compact!
          render 'agent_index'
        end
      }
    end
  end

  
  private
  def account_params
    params.require(:account).permit(:user_class_id, :name, :mobile, :email, :gender, :wechat_id, :password, :password_confirmation, :memory_token)
  end
end
