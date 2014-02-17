class Admin::ToursController < ApplicationController

  def create
    @tour = Tour.new
    @tour.name = params[:tour][:name]
    @tour.description = params[:tour][:description]
    @tour.content = params[:tour][:content]
    @tour.tour_group = UserGroup.convert_name_string_to_id_string(params[:tour][:tour_group])
    @tour.tour_type = params[:tour][:tour_type]
    @tour.account_id = current.id
    if @tour.save
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
      @tour.tour_group = UserGroup.convert_name_string_to_id_string(params[:tour][:tour_group])
      @tour.tour_type = params[:tour][:tour_type]
      if @tour.save
        redirect_to '/admin#admin/index_tour.html'
      else
        redirect_to :back
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
    params.require(:tour).permit(:identifier, :name, :description, :include, :exclude, :transportations, :notes, :visa, 
      :days_attributes => [:id, :tour_id, :number, :accommodation, :breakfast, :lunch, :dinner, :itinerary, :_destroy, 
      :activities_attributes => [:id, :day_id, :time, :active_type, :site_id, :image_id, :short_des, :full_des, :_destroy] ] )
  end
end
