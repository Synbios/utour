json.array!(@bookings) do |booking|
  json.extract! booking, :id, :departure_date, :number_of_people, :package_id, :tour_id
  json.url booking_url(booking, format: :json)
end
