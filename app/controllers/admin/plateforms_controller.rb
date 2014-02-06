class Admin::PlateformsController < ApplicationController

  def dashboard
    @account = Account.first
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
  end

end
