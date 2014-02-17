class Admin::SitesController < ApplicationController
	helper :application
  def create
  	@site = Site.new(site_params)
		respond_to do |format|
			if @site.save
				#format.json { render json: @image, status: :ok }
				format.html { redirect_to '/admin#admin/site_admin.html' } 
			else
				#format.json { render json: @image.errors, status: :failed }
				format.html {
					@sites = Site.all 
					#flash.now[:errors] =  @image.errors
					redirect_to "/admin#admin/site_admin.html", :flash => { :error => @site.errors.to_json }
				}
			end
		end
  end

  def update
  	@site = Site.find_by_id(params[:id])
  	@site.update(site_params)
  	redirect_to '/admin#admin/site_admin.html'
  end

  def destroy
  	@site = Site.find_by_id(params[:id])
  	@site.destroy
  	redirect_to "/admin#admin/site_admin.html", notice: "已删除景点 #{@site.id}"
  end

  def index
  	
  end

  def get_image_list_by_site_id
  	@site = Site.find_by_id(params[:id])
  	@select_id = params[:select_id]
  	@images = @site.images
  	respond_to do |format|
  		format.html { render layout: false }
  		format.js
  	end
  end

  def new
  	@site = Site.new
    1.times { @site.image_and_sites.build }
  end

  private
	def site_params
		params.require(:site).permit(:name, :short_des, :full_des, :image_and_sites_attributes => [:id, :image_id, :site_id, :_destroy] )
	end  
end
