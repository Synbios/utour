class ToursController < ApplicationController
  layout "lion"
  #before_action :store_location, except: [:show]
  before_action :set_tour, only: [:show]
  before_action :check_login, except: [:show]

  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.all
  end

  # GET /tours/1
  # GET /tours/1.json
  def show

  end

  def legacy
    @pictures = JSON.parse(@tour.content)["images"]
    render 'legacy', layout: 'application'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    
end
