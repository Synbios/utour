namespace :erp do
  
  desc "Fetch NEW routes from ERP system and save to local database"
  task fetch_routes: :environment do
    puts "fetching route index"
    # 从马欣端口得到所有在售行程的ID
    # 该端口为一组URL列表
    uri = URI.parse GLOBAL["erp_routes_index"]
    params = {}
    uri.query = URI.encode_www_form params
    res = Net::HTTP.get_response(uri)
    unless res.is_a?(Net::HTTPSuccess)
      puts "http request failed when get routes index"
      return
    end
    index_page = Nokogiri::HTML res.body
    if !index_page.class.to_s.include? "HTML::Document"
      puts "ERROR: API returned index page cannot be recognized (#{index_page.class})"
      return
    end

    # 根据列表分别获取XML文档
    routes = index_page.css("a").map { |a| a["href"] }
    routes.each do |route|
      uri = URI.parse route
      uri.query = URI.encode_www_form params
      res = Net::HTTP.get_response(uri)
      unless res.is_a?(Net::HTTPSuccess)
        puts "ERORR when get response from url = #{route}"
        next
      end
      puts "fetch data from url = #{uri}"
      xml = Nokogiri::XML res.body

      # 分析XML文档
      xml.xpath('//item').each do |tour_xml|

        tour = Tour.find_or_create_by_identifier(tour_xml["lineid"])
        tour.name = tour_xml["title"]
        tour.description = tour_xml["sightSpot"][0..200].gsub(/\s\w+\s*$/,'...')
        tour.expire_date = tour_xml["dateOfExpire"] if !tour_xml["dateOfExpire"].blank?
        tour.departure_city = tour_xml["departure"]
        feature_tags = []
        if !tour_xml["function"].blank? # 线路分类标签
          feature_tags.push FeatureTag.find_or_create_by_name(tour_xml["function"]).name
        end

        if !tour_xml["continent"].blank? # 地区分类标签
          tour_xml["continent"].split(",").compact.each do |area|
            feature_tags.push FeatureTag.find_or_create_by_name(area).name
          end
        end

        if !tour_xml["country"].blank? # 国家分类标签
          tour_xml["country"].split(",").compact.each do |area|
            feature_tags.push FeatureTag.find_or_create_by_name(area).name
          end
        end

        tour.tour_type = feature_tags.join(" ")

        tour.include = tour_xml.xpath('./feeInclude').children.select{|e| e.cdata?}.join
        tour.exclude = tour_xml.xpath('./feeExclude').children.select{|e| e.cdata?}.join
        tour.other_options = tour_xml.xpath('./ownExpense').children.select{|e| e.cdata?}.join
        tour.terms = tour_xml.xpath('./bookingTerms').children.select{|e| e.cdata?}.join
        tour.visa = tour_xml.xpath('./visaInfos').children.select{|e| e.cdata?}.join
        tour.notes = tour_xml.xpath('./tip_present').children.select{|e| e.cdata?}.join
        tour.erp_info = tour_xml.xpath('./miscellaneous').to_xml
        tour.erp_features = tour_xml.xpath('./features').to_xml

        tour.account = Account.find_by_email("youz@ualberta.ca")
        tour.sale_channel = SaleChannel.find_by_name("微分销")
        puts "Updating tour id = #{tour.id} tourid = #{tour.identifier} name = #{tour.name}"
        tour.save
        
        # 根据王媛媛接口 读取团号(用来获取出团通知和word文档), 价格和图片(没有标题和相关行程)
        # 注意!!! 该接口用SOAP XML POST


        query = <<-EOF
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <WFX_GetLineDetailById xmlns="http://tempuri.org/">
      <tdid>#{tour_xml["lineid"]}</tdid>
    </WFX_GetLineDetailById>
  </soap:Body>
</soap:Envelope>
EOF

        host = "www.utourworld.com"
        http = Net::HTTP.new(host)
        res = http.post(GLOBAL["erp_port"], query, { 'Content-Type' => 'text/xml; charset=utf-8' })
        
        puts "fetch alternative data"
        #puts res.body
        # 内容以XML格式直接储存(图片URL显示时候再从XML分析)
        tour.erp_more_info = Nokogiri::XML(res.body).xpath('//line').to_xml

        # 添加出发日期(departure)和价格(price)
        # 注意 departure 用erp的团号区分, 价格在erp内无编号, 默认为同行价(一个departure只有一个同行价)

        dep_array = []
        Nokogiri::XML(res.body).xpath('//promotionItem').each do |item|
          puts "build departure #{item["tdid"]}"
          departure = Departure.find_or_create_by_identifier item["tdid"]

          dep_array.push departure
          departure.date = item["ctdate"]
          departure.tour = tour
          departure.visa_status = "未送签" if departure.visa_status.blank?
          departure.expire_date = tour.expire_date
          departure.number_of_seats = 9 #if departure.number_of_seats.blank?
          departure.sale_channel = SaleChannel.find_by_name("微分销") #if departure.sale_channel_id.blank?
          departure.account = Account.find_by_email("youz@ualberta.ca")


          # 添加价格 (反读马欣)
          price_node = tour_xml.xpath("//routeDate[@tdid=#{departure.identifier}]").first
          
          if price_node.present?
            agent_price = Price.where("departure_id = ? AND kind = ?", departure.id, "同业").first
            if agent_price.nil?
              agent_price = Price.new
              agent_price.departure = departure
              agent_price.kind = "同业"
            end
            agent_price.sale_channel = SaleChannel.find_by_name("会员渠道") #if price.sale_channel_id.blank?
            agent_price.price = price_node["agentPrice"]
            agent_price.account = Account.find_by_email("youz@ualberta.ca") #if price.account_id.blank?
            agent_price.expire_date = departure.expire_date
            puts "add agent price = #{agent_price.price}"
            agent_price.save

            retail_price = Price.where("departure_id = ? AND kind = ?", departure.id, "直客").first
            if retail_price.nil?
              retail_price = Price.new
              retail_price.departure = departure
              retail_price.kind = "直客"
            end
            retail_price.sale_channel = SaleChannel.find_by_name("微分销") #if price.sale_channel_id.blank?
            retail_price.price = price_node["price"]
            retail_price.account = Account.find_by_email("youz@ualberta.ca") #if price.account_id.blank?
            retail_price.expire_date = departure.expire_date
            puts "add retail price = #{retail_price.price}"
            retail_price.save
          end
          
        

          query = <<-EOF
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <WFX_getRouteUrl xmlns="http://tempuri.org/">
      <tdid>#{departure.identifier}</tdid>
    </WFX_getRouteUrl>
  </soap:Body>
</soap:Envelope>
EOF
          res = http.post(GLOBAL["erp_port"], query, { 'Content-Type' => 'text/xml; charset=utf-8' })
          #puts res.body
          if !Nokogiri::XML(res.body).xpath('//RouteUrl').text.blank?
            tour.erp_word_url = Nokogiri::XML(res.body).xpath('//RouteUrl').text
            tour.save
          end
          puts "word url = #{tour.erp_word_url}"

          departure.erp_group_notice_url = Nokogiri::XML(res.body).xpath('//CtInform').text
          departure.save
          puts "group notice url = #{departure.erp_group_notice_url}"
        end

      end

      
    end
  end

end
