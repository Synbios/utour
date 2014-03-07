class ImagesController < ApplicationController
  def show
  	@image = Image.find params[:id]
  	render layout: "front30"
  end
end
