class Admin::FeatureTagsController < ApplicationController
  before_action :set_feature_tag, only: [:new, :destroy]
  def index
  	@feature_tags = FeatureTag.all
  end

  def new
    @feature_tag = FeatureTag.new
  end

  def create
    @feature_tag = FeatureTag.new(feature_tag_params)
    respond_to do |format|
      if @feature_tag.save
        format.html {
          render 'index'
        }
      else
        format.html { render 'new' }
      end
    end
  end

  def destroy
  end

  private
    def set_feature_tags
      @account = FeatureTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feature_tag_params
      params.require(:account).permit(:name, :depth)
    end
end
