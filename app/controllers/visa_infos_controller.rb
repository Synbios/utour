class VisaInfosController < ApplicationController
  def show
    @visa_info = VisaInfo.find params[:id]
    @requirements = @visa_info.requirements.split(/\s*\n+\s*/)
    @notes = @visa_info.notes.split(/\s*\n+\s*/)
  end
end
