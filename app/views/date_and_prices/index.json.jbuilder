json.array!(@date_and_prices) do |date_and_price|
  json.extract! date_and_price, :id, :tour_id, :departure_date, :return_date, :visa_mailing_date, :ticket_issuing_date, :trade_price, :retail_price, :export
  json.url date_and_price_url(date_and_price, format: :json)
end
