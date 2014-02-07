class AccountsController < ApplicationController

  before_action :set_account, only: [:show, :edit, :update, :destroy, :activate_show]
  before_action :signin_filter, except: [:new, :create]
  before_action :self_filter, except: [:new, :create]
  before_action :privilege_filter, except: [:new, :create]

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
    if params[:user_class] == "trade"
      render 'accounts/new/trade', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:trade) } 
    elsif params[:user_class] == "staff"
      render 'accounts/new/staff', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:staff) } 
    else #params[:user_class] == "customer"
      render 'accounts/new/customer', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:customer) } 
    end
  end

  # GET /accounts/activate_show
  def activate_show
    unless @account.active
      render 'activate_show'
    end
  end

  # POST /accounts/activate
  def activate
    @account = Account.find_by_wechat_id(params[:account][:wechat_id])
    if @account.present?
      code = InvitationCode.find_by_account_id(@account.id)
      if code.present? == false
        @account.errors.add(:activation_code, '该邀请码无效') 
        render 'activate_show'
      elsif code.used
        @account.errors.add(:activation_code, '该邀请码已被使用请填入其他激活码') 
        render activate_show_account_path(account)
      elsif Date.today > code.expire_time
        @account.errors.add(:activation_code, '该邀请码已过期请重新申请') 
        render activate_show_account_path(account)
      else 
        flash.now[:notice] = account.activate(code)
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
  def create
    @account = Account.new(account_params)
    @account.user_group_id = 0
    if @account.gender == 2
      @account.gender = "女"
    else
      @account.gender = "男"
    end
    if @account.user_class_id == Account.find_user_class_id_by_name(:trade)
      @account.active = false
    elsif @account.user_class_id == Account.find_user_class_id_by_name(:customer)
      @account.active = true
    else # by customer by default
      @account.active = true
    end

    respond_to do |format|
      if @account.save
        format.html {
          sign_in @account
          redirect_to activate_show_account_path(@account), notice: '新用户申请成功' if @account.user_class_id == Account.find_user_class_id_by_name(:trade)
        }
        format.json { render action: 'show', status: :created, location: @account }
      else
        format.html {
          if @account.user_class_id == Account.find_user_class_id_by_name(:trade)
            render 'accounts/new/trade', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:trade) } 
          elsif @account.user_class_id == Account.find_user_class_id_by_name(:staff)
            render 'accounts/new/staff', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:staff) } 
          else #params[:user_class] == "customer"
            render 'accounts/new/customer', :locals => { "user_class_id" => Account.find_user_class_id_by_name(:customer) } 
          end
        }
        format.json { render json: @account.errors, status: :unprocessable_entity }
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
      params.require(:account).permit(:name, :mobile, :email, :gender, :wechat_id, :password, :password_confirmation, :memory_token, :user_class_id)
    end

    def signin_filter
      redirect_to signin_url, notice: "用户请登录，新用户请先注册！" unless signed_in?
    end

    def self_filter
    end

    def privilege_filter
    end
end
