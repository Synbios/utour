class AccountsController < ApplicationController

  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :check_privilege, except: [:new, :create]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    if @account.gender == 2
      @account.gender = "女"
    else
      @account.gender = "男"
    end
    @account.user_group = "直客"
    @account.superuser = false
    respond_to do |format|
      if @account.save
        format.html {
          redirect_to @account, notice: '新用户申请成功'
          sign_in @account
        }
        format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render action: 'new' }
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
      params.require(:account).permit(:name, :mobile, :email, :gender, :wechat_id, :user_group, :password, :password_confirmation, :memory_token)
    end

    def check_privilege
      redirect_to signin_url, notice: "用户请登录，新用户请先注册！" unless signed_in?
    end
end
