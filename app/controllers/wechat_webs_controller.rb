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
  end

  private

end
