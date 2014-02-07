class Admin::PlateformsController < ApplicationController
  before_action :check_login

  def dashboard
    @account = current_user
    render 'dashboard', :layout => false
  end

  def home
    render 'home', :layout => false
  end

  def inbox
    respond_to do |format|
      format.js { render :layout=>false }
      format.html { render :layout=>false }
    end
  end

  def email_list
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def email_compose
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def calendar
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def invitation_code_control
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def account_control
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def account_admin
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  private
    def check_login
      redirect_to admin_signin_path unless staff_signed_in?
    end

end
