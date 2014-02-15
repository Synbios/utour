class Admin::ImagesController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:create]
	def index
	end

	def show
	end

	def create
		@image = Image.new(image_params)
		respond_to do |format|
			if @image.save
				format.json { render json: @image, status: :ok }
				format.html { redirect_to '/admin#admin/image_admin.html' } 
			else
				format.json { render json: @image.errors, status: :failed }
				format.html {
					@images = Image.all 
					#flash.now[:errors] =  @image.errors
					redirect_to "/admin#admin/image_admin.html", :flash => { :error => @image.errors.to_json }
				}
			end
		end
		
	end

	def destroy
		@image = Image.find_by_id(params[:id])
		@image.destroy
		redirect_to "/admin#admin/image_admin.html", :notice => "图片资源删除成功"
	end

	private
	def image_params
		params.require(:image).permit(:name, :description, :photo)
	end  
end
