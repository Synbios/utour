namespace :erp do
  
  desc "Fetch NEW routes from ERP system and save to local database"
  task fetch_routes: :environment do
    puts "fetching route index"
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

        tour.account_id = 1
        tour.sale_channel_id = 1
        puts "Updating tour id = #{tour.id} tourid = #{tour.identifier} name = #{tour.name}"

        
        # 第2接口读取word文档和行程数据
#        uri = URI.parse GLOBAL["erp_port"]
#        params = { op: "WFX_GetLineDetailById", lineId: tour_xml["lineid"] }


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
        tour.erp_more_info = Nokogiri::XML(res.body).xpath('//line').to_xml

        query = <<-EOF
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <WFX_getRouteUrl xmlns="http://tempuri.org/">
      <tdid>#{tour_xml["lineid"]}</tdid>
    </WFX_getRouteUrl>
  </soap:Body>
</soap:Envelope>
EOF
        res = http.post(GLOBAL["erp_port"], query, { 'Content-Type' => 'text/xml; charset=utf-8' })
        #puts res.body

        tour.word_url = Nokogiri::XML(res.body).xpath('//RouteUrl').text
        puts "word url = #{tour.word_url}"
        tour.save

      end

      
    end
  end

end
