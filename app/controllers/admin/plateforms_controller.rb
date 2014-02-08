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

  def new_tour
    @tour = Tour.new
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def edit_tour
    @tours = Tour.all
    @tour = Tour.find_by_id(params[:id])
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def index_tour
    @tours = Tour.all
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def new_shelf
    @shelf = Shelf.new
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def edit_shelf
    @shelves = Shelf.all
    @shelf = Shelf.find_by_id(params[:id])
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def index_shelf
    @shelves = Shelf.all
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def tag_control
    @feature_tag = FeatureTag.new
    @feature_tags = FeatureTag.all
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  def date_and_price_control
    if params[:date_and_price_id] == "new"
      @date_and_price = DateAndPrice.new
    else
      @date_and_price = DateAndPrice.find_by_id(params[:date_and_price_id])
    end
    @tour = Tour.find_by_id(params[:tour_id])
    @tours = Tour.all
    respond_to do |format|
      format.html { render :layout=>false }
    end
  end

  private
    def check_login
      redirect_to admin_signin_path unless staff_signed_in?
    end

end
