class WechatsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_signature

  def check
    render :text => params[:echostr]
  end

  def message
    #logger.info ">>> DEBUG >>> request type: POST"
    #logger.info ">>> DEBUG >>> message type: POST #{params[:xml][:MsgType]}"
    respond_to do |format|
      format.xml {
        if params[:xml][:MsgType] == "event"
          if params[:xml][:Event] == "subscribe"
            @message = 
            "欢迎关注 UTOUR【成都众信旅游】！我们将竭诚为您服务, 请输入数字以选择下内容:\n" +
            "1. 出国旅游线路咨询\n"+
            "2. 注册众信会员\n"+
            "更多资讯请点击屏幕下方的链接访问我们的分销网或者语音留言与我们联系！"

            render "message", :formats => :xml, :layout => 'wechat_api/text'
          elsif params[:xml][:Event] == "unsubscribe"
            @message = "感谢您对我们的支持！"
            render "message", :formats => :xml, :layout => 'wechat_api/text'
          elsif params[:xml][:Event] == "scan"
          elsif params[:xml][:Event] == "LOCATION"
          elsif params[:xml][:Event] == "CLICK"
          end
        elsif params[:xml][:MsgType] == "text"
          if params[:xml][:Content] =~ /^1\s*/
            @message= "请点击屏幕下方的链接访问成都众信分销网!"
          end
          render "message", :formats => :xml, :layout => 'wechat_api/text'
        elsif params[:xml][:MsgType] == "image"

        elsif params[:xml][:MsgType] == "voice"
        elsif params[:xml][:MsgType] == "video"
        elsif params[:xml][:MsgType] == "location"
        elsif params[:xml][:MsgType] == "link"
        else
          render :text => "message type not supported"
          logger.info "POST does not contain XML params = #{params}"
        end
      }
    end
  end

  private
  def check_signature
    logger.info "CHECKING SIGNATURE"
    logger.info params
    if params[:timestamp].nil? || params[:nonce].nil?
      render :text => "timestamp and nonce params missing ", :status => 403
    else
      array = [WECHAT_TOKEN, params[:timestamp], params[:nonce]].sort
      render :text => "signature check failed", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
    end
  end
end
