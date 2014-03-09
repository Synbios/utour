class Front30Controller < ApplicationController
  layout "front30"

  def home
  	@img1x1s = Image.where("image_type = ?", "首页1x1").shuffle
  	@img2x1s = Image.where("image_type = ?", "首页2x1").shuffle 
  end

  # 企华页
  def landing_page 
  	@page = "/images/xixili.jpg"
  end

  # 出行攻略
  def travel_guide

  end

  def contact_about
  end

  def about
  end

  # 同业计划
  def dm
  end

  # 视频分享
  def video

  end

  def group
    @tours = Tour.where("expire_date > ? AND departure_city = ?", Time.now, "北京")
    @root = JSON.parse Shelf.find_by_name("团队行程").rack
    @set = ["跟团游"]
  end

  def free
  end


end
