class ToursController < ApplicationController
  layout "lion"
  #before_action :store_location, except: [:show]
  before_action :set_tour, only: [:show, :show_docx]
  before_action :check_login, except: [:show, :show_docx]

  # GET /tours
  # GET /tours.json
  def index
    @tours = Tour.all
  end

  # GET /tours/1
  # GET /tours/1.json
  def show
    if @tour.cover_img.nil?
      @cover_img = "default_tour_cover.jpg"
    else
      @cover_img = @tour.cover_img.photo.url(:original)
    end
    if @tour.icon_img.nil?
      @icon_img = "default_tour_icon.png"
    else
      @icon_img = @tour.icon_img.photo.url(:original)
    end
    @xml = Nokogiri::XML(@tour.erp_info)
    @features = Nokogiri::XML(@tour.erp_features).xpath('//feature').children.select{|e| e.cdata?}
    @itineraries = Nokogiri::XML(@tour.erp_info).xpath('//itineraryDay') 
    render layout: "front30"
  end

  # 为word转换而简化的html格式
  def show_docx
    @cover_img = "default_tour_cover.jpg"
    render layout: "docx"
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
