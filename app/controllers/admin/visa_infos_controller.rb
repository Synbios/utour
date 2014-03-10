class Admin::VisaInfosController < ApplicationController
  def new
  end

  def create
    @visa_info = VisaInfo.new visa_info_params
    if @visa_info.save
      redirect_to "http://0.0.0.0:3000/admin#admin/visa_infos"
    else
      redirect_to "http://0.0.0.0:3000/admin#admin/visa_infos"
    end
  end

  def edit
  end

  def upadte
  end

  def destroy
    @visa_info = VisaInfo.find params[:id]
    @visa_info.destroy
    redirect_to "http://0.0.0.0:3000/admin#admin/visa_infos"
  end

  def index
    @visa_info = VisaInfo.new

    @visa_infos = VisaInfo.all
    render layout: false
  end

  def visa_info_params
    params.require(:visa_info).permit(:country, :requirements, :notes, :form)
  end
end
