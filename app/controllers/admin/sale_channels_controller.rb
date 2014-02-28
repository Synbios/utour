class Admin::SaleChannelsController < ApplicationController
  before_action :set_sale_channel, only: [:edit, :update, :destroy]
  
  def create
    @sale_channel = SaleChannel.new(sale_channel_params)

    respond_to do |format|
      if @sale_channel.save
        rebuild_sale_channel_map
        format.json { render json: @code, status: :ok }
        #format.html { redirect_to '/admin#admin/account_control.html', notice: '成功建立新用户组' }
        
      else
        #format.html { render action: 'new' }
        format.json { render json: @sale_channel.errors, status: :failed }
        
      end
    end
  end

  def index
  	@sale_channels = SaleChannel.all
    @trees = SaleChannel.get_trees

  end

  def destroy
    @sale_channel.destroy
    rebuild_sale_channel_map
    respond_to do |format|
      format.html { redirect_to '/admin#admin/account_control.html', notice: '成功删除新用户组' }
      format.json { render json: nil, status: :ok }
    end
  end

  def update
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale_channel
      @sale_channel = SaleChannel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_channel_params
      params.require(:sale_channel).permit(:name, :abb, :parent_id)
    end

    def rebuild_sale_channel_map
      SaleChannelMap.reload
    end
end
