#require 'SecureRandom'

class Admin::InvitationCodesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def new
    @code = InvitationCode.new
  end

  def create
  	@code = InvitationCode.new(invitation_code_params)
    @code.issued_by = 1
    @code.used_by = nil
    @code.used_at = nil
    @code.cancelled = false
    #@code.code = SecureRandom.hex(4)
    @code.code = (rand * 10000000000).to_i.to_s
    @code.expire_time = Time.now + 7.days 

    respond_to do |format|
      if @code.save
        format.js
        format.json {render json: @code, status: :ok }
        format.html { redirect_to '/admin#admin/invitation_code_control.html' }
      else
        format.json { render json: @code.errors, status: :failed }
      end
    end
  end

  def cancel
    @code = InvitationCode.find_by_id(params[:id])
    if @code.nil? == false
      if @code.cancelled
        flash.now[:error] = "注册码取消错误: 请勿重复取消"
      else
        @code.cancelled = true
         if @code.save
          flash.now[:notice] = "注册已码取消"
        else
          flash.now[:error] = "注册码取消错误: 数据未保存"
        end
      end
    else
      flash.now[:error] = "注册码取消错误: 该注册码不存在"
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render js: "reload_invitation_code_table();" }
    end
  end

  def destroy
    @code = InvitationCode.find_by_id(params[:id])
    @code.destroy
    respond_to do |format|
      format.html { redirect_to '/admin#admin/invitation_code_control.html' }
      format.js
    end
  end

  def index
    @codes = InvitationCode.all
    # @return = Jbuilder.encode do |json|
    #   json.iTotalRecords @codes.count
    #   json.iTotalDisplayRecords @codes.count
    #   json.sEcho params[:sEcho]
      
    #   json.aaData @codes, :user_class_id, :created_at, :user_group_id, :expire_time, :account_id, :used, :code

    # end
    respond_to do |format|
      format.json { render json: @return }
      format.js
      #format.html { render }
    end
  end

  private
    def invitation_code_params
      params.require(:invitation_code).permit(:user_class_id, :user_group_id)
    end
end
