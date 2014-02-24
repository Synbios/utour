class WechatWebsController < ApplicationController
  before_action :store_location, only: [:trade]
	layout "lion"
  
  def tiger
  	render 'tiger', :layout => 'tiger'
  end

  def lion
    render 'lion', layout: "application"
  end

  # 签证资料
  def visa

  end

  # 团队行程
  def group_travel
  	@tours = Tour.all
    @root = JSON.parse Shelf.find_by_name("团队行程").rack
    @set = ["团队行程"]
  end

  # 自由行
  def diy
    @tours = Tour.all
    @root = JSON.parse Shelf.find_by_name("自由行").rack
    @set = ["自由行"]
    render 'group_travel'
  end

  # 同业动态
  def trade
    account = trade_or_staff?
    puts ">>>>>>>>>>>>>>> #{account}"
    if account.nil? # 要求登录
      redirect_to :controller=> 'sessions', :action => 'new', :user_class => 'trade'
    else
      puts ">>>>>>>>>>>>>>>>>>#{account.active} >>>>>>>>>>>>>>>>>>>#{activate_show_account_path(account)}"
      redirect_to activate_show_account_path(account) if account.active == false # 要求注册码激活
    end
  end

  #出团视频
  def video
  end

  # 我的众信
  def booking
  end


  def status
  end

  # 出团说明
  def info
  end

  # 出行攻略
  def guide
  end

  # 特别推荐
  def sale
    account = trade_or_staff?
    puts ">>>>>>>>>>>>>>> #{account}"
    if account.nil? # 要求登录
      redirect_to :controller=> 'sessions', :action => 'new', :user_class => 'trade'
    else
      redirect_to '/images/dm.jpg'
      #puts ">>>>>>>>>>>>>>>>>>#{account.active} >>>>>>>>>>>>>>>>>>>#{activate_show_account_path(account)}"
      #redirect_to activate_show_account_path(account) if account.active == false # 要求注册码激活
    end
    # @tours = Tour.all
    # @root = JSON.parse Shelf.find_by_name("特惠行程").rack
    # @set = ["特惠行程"]
    # render 'group_travel'
  end

  def contact
    @account = current_user
  end

  def feedback
    WexchatMailer.contact_message(params[:name], params[:contact], params[:content]).deliver
    @account = current_user
    @message = "您的问题已提交, 我们会尽快与您联系."
    render 'contact'
  end

  private

end
