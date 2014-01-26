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
  	@tours = Tour.where('tour_type' => "group")
  end

  # 自由行
  def diy
  end

  # 同业动态
  def trade
    account = account_filter(:trade, :all)
    if account.nil?
      redirect_to :controller=> 'sessions', :action => 'new', :user_class => 'trade'
    else
      redirect_to activate_show_account_path(account) if account.active != 1
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
  def store_location
    if request.get?
      #puts ">>>>>>>>>>>>>>>>>> STORE LOCATION: #{request.url} = #{request.protocol} #{request.host_with_port} #{request.fullpath}"
      session[:return_to] = request.url
    else
      session[:return_to] = request.referer
    end
  end

end
