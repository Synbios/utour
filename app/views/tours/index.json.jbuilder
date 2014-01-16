json.array!(@tours) do |tour|
  json.extract! tour, :id, :identifier, :name, :content, :departure_date, :return_date, :visa_mailing_date, :ticket_issuing_date, :trade_price, :retail_price
  json.url tour_url(tour, format: :json)
end
