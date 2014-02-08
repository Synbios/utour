class Admin::FeatureTagsController < ApplicationController
  before_action :set_feature_tag, only: [:destroy]
  def index
  	@feature_tags = FeatureTag.all
  end

  def new
    @feature_tag = FeatureTag.new
  end

  def create
    @feature_tag = FeatureTag.new(feature_tag_params)
    if @feature_tag.save
        redirect_to '/admin#admin/tag_control.html'
      else
        flash.now[:error] = @feature_tag.errors.full_messages
        redirect_to '/admin#admin/tag_control.html'
      end
  end

  def destroy
    @feature_tag.destroy
    redirect_to '/admin#admin/tag_control.html'
  end

  private
    def set_feature_tag
      @feature_tag = FeatureTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feature_tag_params
      params.require(:feature_tag).permit(:name)
    end
end
