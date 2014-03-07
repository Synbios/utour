class Front30Controller < ApplicationController
  layout "front30"

  def home
  	@img1x1s = Image.where("image_type = ?", "首页1x1").shuffle
  	@img2x1s = Image.where("image_type = ?", "首页2x1").shuffle 
  end
end
