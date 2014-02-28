class AccountsController < ApplicationController

  before_action :set_account, only: [:show, :edit, :update, :destroy, :activate_show]
  before_action :check_login, except: [:new, :create]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    #redirect_to activate_show_account_path(@account)
  end

  # GET /accounts/new
  def new
    @account = Account.new
    # if params[:user_class] == "trade"
    #   render 'accounts/new/trade', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:trade) } 
    # elsif params[:user_class] == "staff"
    #   render 'accounts/new/staff', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:staff) } 
    # else #params[:user_class] == "customer"
    #   render 'accounts/new/customer', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:customer) } 
    # end
    render 'accounts/new'
  end

  # GET /accounts/activate_show
  def activate_show
    @contact = Account.sale_contact
    unless @account.active
      render 'activate_show'
    end
  end

  # POST /accounts/activate
  def activate
    @account = Account.find_by_wechat_id(params[:account][:wechat_id])
    if @account.present?
      code = InvitationCode.find_by_code(params[:account][:activation_code])
      if code.present? == false
        @account.errors.add(:activation_code, '该邀请码无效') 
        render 'activate_show'
      elsif code.status[:state] != :ok
        #puts ">>>>>>>>>>>>>>>>>>#{code.status}"
        @account.errors.add(:activation_code, code.status[:message])
        render 'activate_show'
      # elsif code.used
      #   @account.errors.add(:activation_code, '该邀请码已被使用请填入其他激活码') 
      #   render activate_show_account_path(account)
      # elsif Date.today > code.expire_time
      #   @account.errors.add(:activation_code, '该邀请码已过期请重新申请') 
      #   render activate_show_account_path(account)
      elsif code.user_class_id != @account.user_class_id
        @account.errors.add(:activation_code, "该邀请码非同业注册邀请码")
        render 'activate_show'
      else
        @account.update_attribute(:sale_channel, code.sale_channel)
        @account.update_attribute(:active, true)

        SaleAgent.new(sale_id: code.account.id, agent_id: @account.id).save
        
        code.use(@account)
        flash.now[:notice] = "账户验证成功"
        redirect_back_or_default
      end
    else
      render text: "WECHAT_ID #{params[:wechat_id]} not found"
    end
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  # 注册同行账号
  def create
    @account = Account.new(account_params)
    if @account.gender == 2
      @account.gender = "女"
    else
      @account.gender = "男"
    end
    @account.user_class_id = 5 # 5 = 同行

    # if @account.is_trade == "1"
    #   @account.active = false
    #   @account.set_trade
    # else
    #   @account.active = true
    #   @account.set_customer
    # end

    respond_to do |format|
      if @account.save
       # if @account.is_trade == "1"
          WexchatMailer.trader_welcome_email(@account).deliver
       # else
       #   WexchatMailer.customer_welcome_email(@account).deliver
       # end
        format.html {
          sign_in @account
          #puts ">>>>>>>>>> #{@account.user_class_id} #{@account.user_class_id == 3} #{@account.user_class_id == '3'} #{@account.trade?} >>>>>>>>>>>> #{activate_show_account_path(@account)} "
          redirect_to activate_show_account_path(@account), notice: '新用户申请成功'
          # if @account.trade?

          #   redirect_to activate_show_account_path(@account), notice: '新用户申请成功'
          # else
            
          #   redirect_back_or_default
          # end
        }
        #format.json { render action: 'show', status: :created, location: @account }
      else
        format.html {
          # if @account.user_class_id == Account.find_user_class_id_by_name(:trade)
          #   render 'accounts/new/trade', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:trade) } 
          # elsif @account.user_class_id == Account.find_user_class_id_by_name(:staff)
          #   render 'accounts/new/staff', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:staff) } 
          # else #params[:user_class] == "customer"
          #   render 'accounts/new/customer', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:customer) } 
          # end
          render 'accounts/new'
        }
        #format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:company_name, :name, :mobile, :email, :gender, :wechat_id, :password, :password_confirmation, :memory_token)
    end
end
