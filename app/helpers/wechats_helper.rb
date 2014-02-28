module WechatsHelper

  # 获取微信 access_token
  # 返回 {"access_token"=>"15XhYAiZrgn9", "expires_in"=>7200} OR nil
  def wechat_get_access_token
    uri = URI.parse GLOBAL["access_token_url"]
    params = { :grant_type => "client_credential", :appid => GLOBAL["appid"], :secret => GLOBAL["secret"] }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    JSON.parse res.body if res.is_a?(Net::HTTPSuccess)
  end

  # 获取2D码ticket
  def wechat_get_qr_code_ticket(id=1)
    uri = URI.parse GLOBAL["qr_code_ticket_url"]
    access_token = wechat_get_access_token
    if access_token.present? && access_token["access_token"].present?
      access_token = access_token["access_token"]
    else
      return nil
    end
    data = Jbuilder.encode do |json|
      json.access_token access_token
      json.action_name "QR_LIMIT_SCENE"

      json.action_info do
        json.scene do
          json.scene_id id
        end
      
      end
    end

    res = Net::HTTP.post_form(uri, JSON.parse(data))
    puts res.body
    #puts data
  end

  # 获取2D码图片
  def wechat_get_qr_code(id=1)
    ticket = wechat_get_qr_code_ticket
    if ticket.present? && ticket["ticket"].present?
      ticket = ticket["ticket"]
    else
      return nil
    end
    uri = URI.parse GLOBAL["qr_code_show_url"]
    params = { :ticket => ticket }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    return res.body if res.is_a?(Net::HTTPSuccess)
    return nil
  end

end
