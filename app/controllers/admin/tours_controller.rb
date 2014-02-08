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
end
