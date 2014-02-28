class Admin::ToursController < ApplicationController

  def create
    @tour = Tour.new(tour_params)
    @tour.content = params[:tour][:content]
    #@tour.tour_group = UserGroup.convert_name_string_to_id_string(params[:tour][:tour_group])
    @tour.tour_type = params[:tour][:tour_type]
    @tour.account_id = current_user.id

    if @tour.save
      @tour.generate_itinerary
      @tour.generate_title
      redirect_to '/admin#admin/index_tour.html'
    else
      redirect_to :back
    end
  end

  def update
    @tour = Tour.find_by_id(params[:id])
    unless @tour.nil?
      @tour.name = params[:tour][:name]
      @tour.description = params[:tour][:description]
      @tour.content = params[:tour][:content]
     #@tour.tour_group = UserGroup.convert_name_string_to_id_string(params[:tour][:tour_group])
      @tour.tour_type = params[:tour][:tour_type]
      respond_to do |format|
        if @tour.update(tour_params)
          format.html { redirect_to '/admin#admin/index_tour.html' }
          format.json { head :no_content }
        else
          format.html { redirect_to :back }
          format.json { render json: @fee.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @tour = Tour.find_by_id(params[:id])
    @tour.destroy
    redirect_to "/admin#admin/index_tour.html"
  end

  private
  def tour_params
    params.require(:tour).permit(:identifier, :name, :description, :sale_channel_id, :include, :exclude, :transportations, :notes, :visa, 
      :days_attributes => [:id, :tour_id, :number, :accommodation, :breakfast, :lunch, :dinner, :title, :itinerary, :_destroy, 
        :activities_attributes => [:id, :day_id, :time, :active_type, :site_id, :image_id, :short_des, :full_des, :_destroy] ] )
  end
end
