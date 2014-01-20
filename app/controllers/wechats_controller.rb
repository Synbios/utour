class WechatsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_signature

  def check
    render :text => params[:echostr]
  end

  def message
    puts "MESSAGE CALLED"

    if params[:xml].present? && params[:xml][:MsgType] == "text"
      respond_to do |format|
      format.xml { 
        puts ">>>>>>>>>>>>>>>>>>>> XML REQUEST"
        render "echo", :formats => :xml
      }
      format.html { 
        puts ">>>>>>>>>>>>>>>>>>>> HTML REQUEST"
        render "echo", :formats => :xml
      }
      end
      
    else
      render :text => "message type not supported"
    end
  end
 
  private
    def check_signature
      puts params
      if params[:timestamp].nil? || params[:nonce].nil?
        render :text => "timestamp and nonce params missing ", :status => 403
      else
        array = [WECHAT_TOKEN, params[:timestamp], params[:nonce]].sort
        render :text => "signature check failed", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
      end
    end
end
